import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const json = (body: unknown, status = 200) => new Response(JSON.stringify(body), {
  status, headers: { 'Content-Type': 'application/json' },
});

function getPath(value: Record<string, unknown>, path: string) {
  return path.split('.').reduce<unknown>((current, key) => (current && typeof current === 'object') ? (current as Record<string, unknown>)[key] : undefined, value);
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') return json({ error: 'Method not allowed' }, 405);
  const secret = Deno.env.get('WOMPI_EVENTS_SECRET');
  const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
  const serviceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
  if (!secret) return json({ error: 'Webhook no configurado' }, 500);
  const event = await req.json();
  if (event.event !== 'transaction.updated') return json({ received: true });
  const transaction = event.data?.transaction;
  const properties = event.signature?.properties;
  const checksum = event.signature?.checksum || req.headers.get('X-Event-Checksum');
  if (!transaction || !Array.isArray(properties) || !checksum) return json({ error: 'Evento incompleto' }, 400);
  const values = properties.map((property: string) => String(getPath(event.data, property))).join('');
  const raw = `${values}${event.timestamp}${secret}`;
  const digest = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(raw));
  const expected = [...new Uint8Array(digest)].map(byte => byte.toString(16).padStart(2, '0')).join('').toUpperCase();
  if (expected !== String(checksum).toUpperCase()) return json({ error: 'Firma inválida' }, 401);

  const admin = createClient(supabaseUrl, serviceKey);
  const status = transaction.status;
  const paymentStatus = status === 'APPROVED' ? 'paid' : ['DECLINED', 'VOIDED', 'ERROR'].includes(status) ? 'failed' : 'pending';
  const update: Record<string, unknown> = { payment_status: paymentStatus, payment_transaction_id: transaction.id };
  if (paymentStatus === 'paid') { update.status = 'confirmed'; update.paid_at = new Date().toISOString(); }
  const { error } = await admin.from('reservations').update(update).eq('payment_reference', transaction.reference);
  if (error) return json({ error: error.message }, 500);
  return json({ received: true });
});

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
};

const json = (body: unknown, status = 200) => new Response(JSON.stringify(body), {
  status,
  headers: { ...corsHeaders, 'Content-Type': 'application/json' },
});

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });
  if (req.method !== 'POST') return json({ error: 'Method not allowed' }, 405);

  const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
  const serviceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
  const wompiPublicKey = Deno.env.get('WOMPI_PUBLIC_KEY');
  const integritySecret = Deno.env.get('WOMPI_INTEGRITY_SECRET');
  const appUrl = Deno.env.get('APP_URL') || 'http://localhost:8000/';
  if (!wompiPublicKey || !integritySecret) return json({ error: 'Wompi no está configurado en el backend' }, 500);

  const token = req.headers.get('Authorization')?.replace(/^Bearer\s+/i, '');
  if (!token) return json({ error: 'Debes iniciar sesión' }, 401);
  const admin = createClient(supabaseUrl, serviceKey);
  const { data: { user }, error: userError } = await admin.auth.getUser(token);
  if (userError || !user) return json({ error: 'Sesión inválida' }, 401);

  const body = await req.json();
  const spaceId = String(body.spaceId || '');
  const quantity = Math.max(1, Number(body.quantity) || 1);
  const unit = String(body.unit || 'day');
  const startDate = body.startDate || null;
  const endDate = body.endDate || null;
  if ((startDate && !endDate) || (!startDate && endDate) || (startDate && endDate && endDate < startDate)) {
    return json({ error: 'El rango de fechas no es válido' }, 400);
  }
  const { data: space, error: spaceError } = await admin.from('spaces').select('id,owner_id,name,price,unit,status').eq('id', spaceId).single();
  if (spaceError || !space) return json({ error: 'Espacio no encontrado' }, 404);
  if (space.status !== 'available') return json({ error: 'El espacio no está disponible' }, 409);
  if (space.owner_id === user.id) return json({ error: 'No puedes reservar tu propio espacio' }, 400);

  if (startDate && endDate) {
    const { data: conflicts, error: conflictError } = await admin.from('reservations')
      .select('id').eq('space_id', space.id).in('status', ['confirmed', 'accepted'])
      .lte('start_date', endDate).gte('end_date', startDate).limit(1);
    if (conflictError) return json({ error: conflictError.message }, 500);
    if (conflicts?.length) return json({ error: 'El espacio ya está reservado para esas fechas' }, 409);
  }

  const base = Math.round(Number(space.price) * quantity);
  const total = Math.round(base * 1.28);
  if (!base || total <= 0) return json({ error: 'El espacio no tiene una tarifa válida' }, 400);
  const reservationId = `RES-${crypto.randomUUID()}`;
  const reference = `LOC-${reservationId}`.slice(0, 250);
  const amountInCents = total * 100;
  const checksumBytes = new TextEncoder().encode(`${reference}${amountInCents}COP${integritySecret}`);
  const digest = await crypto.subtle.digest('SHA-256', checksumBytes);
  const integrity = [...new Uint8Array(digest)].map(byte => byte.toString(16).padStart(2, '0')).join('');

  const { error: reservationError } = await admin.from('reservations').insert({
    id: reservationId, user_id: user.id, owner_id: space.owner_id, space_id: space.id,
    quantity, unit, total, status: 'requested', payment_status: 'pending', payment_reference: reference,
    start_date: startDate, end_date: endDate,
  });
  if (reservationError) return json({ error: reservationError.message }, 400);

  return json({ reservationId, reference, amountInCents, currency: 'COP', publicKey: wompiPublicKey,
    integrity, redirectUrl: `${appUrl}?screen=paymentResult&reservation=${encodeURIComponent(reservationId)}` });
});

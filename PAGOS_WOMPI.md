# Pagos y confirmación con Wompi

El flujo usa Wompi en Colombia y Supabase Edge Functions:

1. El emprendedor completa la reserva y se autentica.
2. `create-payment` valida al usuario y al espacio, calcula el total en el servidor, crea la reserva con `payment_status = pending` y devuelve la firma de integridad.
3. El frontend abre el checkout de Wompi. La aplicación nunca recibe ni guarda números de tarjeta; Wompi procesa tarjeta, PSE o Nequi. La redirección solo informa al usuario; no confirma el pago.
4. `wompi-webhook` valida el checksum de Wompi y cambia la reserva a `paid`/`confirmed` únicamente con `APPROVED`. Los estados `DECLINED`, `VOIDED` y `ERROR` quedan como `failed`.

## Configuración en Supabase

Instala y autentica Supabase CLI y, desde la raíz del proyecto, ejecuta:

```bash
supabase link --project-ref iqlkyarfrntzknokmblxb
supabase db push
supabase secrets set WOMPI_PUBLIC_KEY=pub_test_... WOMPI_INTEGRITY_SECRET=test_integrity_... WOMPI_EVENTS_SECRET=test_events_... APP_URL=https://TU_USUARIO.github.io/localmente/
supabase functions deploy create-payment
supabase functions deploy wompi-webhook --no-verify-jwt
```

No guardes la llave privada ni los secretos de integridad/eventos en el frontend o en Git.

En el panel de Wompi Sandbox configura como URL de eventos:

```text
https://iqlkyarfrntzknokmblxb.supabase.co/functions/v1/wompi-webhook
```

Configura otra URL y otros secretos para producción. Antes de cobrar dinero real hay que probar `APPROVED`, `DECLINED`, reintentos e idempotencia del webhook.

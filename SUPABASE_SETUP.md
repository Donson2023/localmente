# Conectar Localmente con Supabase

1. Crea un proyecto en Supabase.
2. En **Project Settings → API**, copia la **Project URL** y la clave pública **anon** en `supabase-config.js`:

```js
window.LOCALMENTE_SUPABASE_CONFIG = {
  url: 'https://tu-proyecto.supabase.co',
  anonKey: 'tu-clave-anon'
};
```

No uses la clave `service_role` en el navegador.

3. Abre **SQL Editor** en Supabase y ejecuta todo el archivo `supabase-schema.sql`.
4. En **Authentication → Providers**, activa Email.
5. Para probar sin confirmación por correo, desactiva temporalmente **Confirm email**. En producción conviene mantenerla activada.
6. Recarga `http://localhost:8000`, abre el icono de cuenta y registra un usuario como propietario o emprendedor.

La aplicación usa Supabase Auth para `signUp`, `signInWithPassword` y cierre de sesión. Los perfiles, espacios y reservas se guardan en tablas protegidas con Row Level Security.

## Correo real de restablecimiento

El enlace **Olvidé la contraseña** usa `resetPasswordForEmail`. Para que el usuario reciba un correo enviado por Localmente:

1. En Supabase abre **Authentication → SMTP Settings** y configura un proveedor SMTP propio (por ejemplo Resend, Brevo o SendGrid).
2. Usa un remitente verificado, por ejemplo `no-reply@localmente.co`, con el nombre `Localmente`.
3. En **Authentication → URL Configuration**, agrega como Redirect URL la URL pública de la aplicación y, para pruebas locales, `http://localhost:8000/?screen=passwordReset`.
4. En **Authentication → Email Templates → Reset Password**, configura el asunto `Restablece tu contraseña en Localmente` y conserva `{{ .ConfirmationURL }}` dentro del botón o enlace del correo.

Plantilla mínima del botón:

```html
<a href="{{ .ConfirmationURL }}" style="background:#fd8a30;color:#311300;padding:14px 22px;border-radius:999px;text-decoration:none;font-weight:700;display:inline-block;">
  Restablecer contraseña
</a>
```

Sin SMTP personalizado, Supabase limita el envío a direcciones autorizadas del proyecto; no debe considerarse listo para usuarios públicos. La aplicación ya no cambia contraseñas localmente: si el correo no puede enviarse, muestra el error y conserva la contraseña actual.

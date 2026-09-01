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

# Ejecutar Localmente en cualquier dispositivo

El proyecto es una web estática. Para abrirlo en otro equipo:

```bash
git clone git@github.com:Donson2023/localmente.git
cd localmente
python3 -m http.server 8000
```

Después abre `http://localhost:8000/`.

También puede servirse desde cualquier hosting estático. No depende de `/Users/mac` ni de una copia fuera del repositorio. Las imágenes y archivos de la aplicación están versionados en Git.

La aplicación usa servicios externos para fuentes, Leaflet, geocodificación (OpenStreetMap/Nominatim) y, si está configurado, Supabase. Por eso requiere conexión a internet para esas funciones; no requiere que este Mac esté encendido.

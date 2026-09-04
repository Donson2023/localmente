# Localmente

Prototipo vertical navegable para el marketplace de espacios comerciales. El piloto inicial está enfocado en Yopal, Casanare; Bogotá queda como catálogo secundario.

## Ejecutar localmente

```bash
cd /Users/mac/Projects/localmente
python3 -m http.server 8000
```

Si `python3` no está disponible en macOS, usa:

```bash
cd /Users/mac/Projects/localmente
ruby -run -e httpd . -p 8000
```

Abrir: <http://localhost:8000/>

## Stitch MCP

La configuración MCP está en `~/.codex/config.toml` y usa la variable de entorno `STITCH_API_KEY`. Define una clave nueva y reinicia Codex:

```bash
export STITCH_API_KEY='CLAVE_NUEVA'
```

No usar la clave que fue compartida en el chat; debe permanecer revocada.

## Punto de entrada

- `index.html`: mapa navegable del flujo.
- `FLUJO.md`: orden principal y ramas.
- `STATUS.md`: último avance y próximos pasos.

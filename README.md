# Localmente

Prototipo vertical navegable para el marketplace de espacios comerciales. El piloto inicial está enfocado en Yopal, Casanare; Bogotá queda como catálogo secundario.

## Fuente de verdad y versión

La rama canónica del proyecto es `main`. Antes de abrir la webapp, comprueba la versión con:

```bash
cd /Users/mac/Projects/localmente
git fetch origin
git status --short --branch
git log -1 --oneline --decorate
```

La webapp local debe servirse desde esta carpeta (`/Users/mac/Projects/localmente`), no desde una copia paralela. Las ramas de trabajo se integran en `main` antes de considerarse la última versión.

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

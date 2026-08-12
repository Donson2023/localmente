# Stitch MCP

Codex now has the Stitch MCP endpoint configured in `~/.codex/config.toml` without storing the API key in the file.

Before restarting Codex, set the rotated key in your shell:

```bash
export STITCH_API_KEY='PEGA_AQUI_LA_CLAVE_NUEVA'
```

Do not reuse the key shared in chat. Open the local prototype from [`index.html`](index.html) after starting the HTTP server in this folder.

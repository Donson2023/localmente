# Estado del proyecto

## Último avance

- El piloto comercial se definió para Yopal, Casanare, con ubicación inicial, mapa y publicación de espacios orientados a esa ciudad.
- Proyecto consolidado en el repositorio Git; las rutas de ejecución son relativas a la carpeta clonada.
- Se creó un índice navegable en `index.html`.
- El flujo está organizado como app vertical: entrada, descubrimiento, búsqueda, filtros/mapa, perfil, chat, reserva, pago y confirmación.
- Se conservaron las pantallas originales y las ramas del propietario: onboarding, verificación, dashboard y edición del espacio.
- Se añadió configuración de Stitch MCP en `~/.codex/config.toml` usando `STITCH_API_KEY`, sin guardar la clave en el proyecto.
- Se conectó el recorrido local básico entre búsqueda, filtros, perfil, chat, calendario y mensajes.
- Se corrigieron los enlaces del índice que todavía apuntaban a la exportación antigua de Stitch.

## Para retomar

1. Abrir `index.html` desde `http://localhost:8000/`.
2. Revisar el recorrido principal en `FLUJO.md`.
3. Definir una API key nueva de Stitch en `STITCH_API_KEY` y reiniciar Codex.
4. Completar las acciones secundarias de cada pantalla y validar el recorrido en un navegador local.

## Nota de sesión

- La sesión actual de Stitch respondió `Auth required`; la clave compartida no se aplicó al proceso MCP ya iniciado.
- El servidor local no pudo validarse desde este entorno porque las conexiones a `localhost` están restringidas, pero los archivos quedaron listos para abrirse con el comando del README.

## Decisiones visuales

- Mantener el diseño mobile-first y el ancho de referencia de teléfono.
- No convertir el prototipo en un dashboard web de escritorio.
- Preservar colores, tipografías, tarjetas, navegación inferior y jerarquía visual de los mockups.

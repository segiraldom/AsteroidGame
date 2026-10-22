# Contexto del Proyecto

**Proyecto:** AsteroidGame (GameMaker LTS 2026, runtime 2026.0.0.23)
**Ruta:** C:\Users\User\GameMakerProjects\AsteroidGame
**Control de versiones:** repositorio Git en GitHub (la copia de seguridad ya está hecha).

## Herramientas y limitaciones
- Tienes el servidor MCP "gml" para leer y editar recursos (objetos, eventos, scripts, salas).
- No puedes compilar ni ejecutar el juego. Yo lo pruebo con Run en el IDE y te pego los errores.
- No hay runtime accesible para el servidor, así que las herramientas de búsqueda y verificación de funciones GML pueden fallar. Si dudas de que una función exista, dímelo en vez de inventarla.
- No puedes crear sprites ni sonidos. Usa placeholders (reutilizar sprites existentes con image_blend o escala, o dibujar con funciones draw_*) y al final dame una lista de los recursos que me faltan por conseguir.
- No ejecutas git; sigue la sección Git.

## Estado actual
- objPlayer: flecha arriba = avanzar, izquierda/derecha = girar, clic izquierdo = disparar, move_wrap.
- objRock: se mueve al azar; al recibir una bala, la roca grande se parte en una pequeña; la pequeña se destruye.
- objBullet: velocidad 12; se destruye al salir de la pantalla.
- objGame: vacío, sin eventos.
- Room1: 1000x700, con 1 nave y 3 rocas. Es la única sala.
- Sprites: sprBullet, sprPlayer, sprRockBig, sprRockSmall. No hay scripts ni sonidos.

## Pedido del profesor
El proyecto se presentará en un evento de la universidad. El profesor pidió mejorarlo para ese evento. Lo único obligatorio es una sala de inicio; el resto es hacer el proyecto más complejo, con libertad creativa.

## Prioridad
El juego debe quedar siempre jugable y estable. Cada paso debe dejarlo funcionando. Es mejor tener menos funciones que funcionen bien que muchas a medias.

## Ideas de funcionalidades (orden sugerido)
1. Sala de inicio (rmMenu) con botones Jugar y Salir, como sala inicial del juego.
2. HUD en pantalla: puntaje, vidas y nivel actual.
3. Sistema de vidas y puntaje, con pantalla de "game over" que permita volver al menú.
4. Niveles con dificultad creciente: más asteroides, más velocidad y distintos tipos. Recomienda un número adecuado de niveles (mi sugerencia: 10, con jefe en el 5 y el 10).
5. Ayudas (power-ups) que aparecen cada cierto tiempo: escudo, más disparos o más daño. Pueden durar un tiempo o un nivel.
6. Explosión de la nave al perder una vida.
7. Jefes (al final, es lo más complejo): roca gigante y alienígena tipo pulpo que lanza rocas.

## Extras para el evento (propón y pregúntame)
- Volver solo al menú tras el game over, por si el juego queda corriendo en un stand.
- Guardar la puntuación más alta.
- Tener en cuenta la resolución de pantalla del evento (la sala actual es 1000x700).

## Convenciones de código
- Nombres: objX, sprX, rmX, scrX, sndX (como ya uso en el proyecto).
- Usa objGame como controlador con las variables globales (puntaje, vidas, nivel).
- Comentarios en español.
- No edites los archivos .yy a mano; usa las herramientas del servidor.
- Modifica solo lo necesario para la funcionalidad actual. No renombres ni borres recursos existentes sin preguntarme antes.
- Evita números mágicos: define constantes o variables con nombre claro (por ejemplo, velocidad de la bala, vidas iniciales).

## Forma de trabajo
1. Antes de cambiar nada, analiza este archivo y muéstrame un plan de desarrollo. Espera mi aprobación.
2. Por cada funcionalidad: explica qué vas a hacer, haz los cambios, y dime exactamente qué probar y qué debería pasar.
3. Si falla, te pegaré el mensaje de error completo y lo que hice. Itera en esa funcionalidad hasta que funcione, y solo entonces pasa a la siguiente.
4. Haz un cambio a la vez.
5. Una funcionalidad está terminada solo cuando: el juego abre sin errores, la funcionalidad hace lo esperado, y lo que ya funcionaba antes sigue funcionando.

## Git (manual, yo ejecuto los comandos)
Tú no ejecutas git. Yo hago los commits a mano desde mi terminal, así que tu trabajo es decirme cuándo y con qué mensaje.

- Trabajamos directo en la rama `main`. El proyecto es pequeño y no hace falta más.
- Un commit por funcionalidad, solo cuando yo confirme que funciona. Nunca de algo sin probar o con errores.
- Cuando yo te diga "funciona", respóndeme con:
  1. Un mensaje de commit en español, imperativo, con prefijo `feat:` (algo nuevo), `fix:` (corrección) o `refactor:` (reorganizar sin cambiar el comportamiento). Ejemplo: `feat: agrega sala de inicio con botones Jugar y Salir`
  2. Los comandos exactos, para copiar y pegar en la carpeta del proyecto:
```
     git add .
     git commit -m "feat: ..."
     git push
```
  3. Una línea con los archivos que cambiaste, para que yo los compare con lo que muestre `git status`.
- Si hay archivos inesperados en `git status` (carpetas de compilación, caché), avísame antes de que haga el commit.
- Cuando termine un hito importante (por ejemplo, el juego completo sin jefes), propón una etiqueta: `git tag v0.1-sin-jefes` y `git push --tags`, para poder volver a una versión estable antes del evento.

## Tarea inicial
Después de que apruebe el plan, empieza por rmMenu con los botones Jugar y Salir.
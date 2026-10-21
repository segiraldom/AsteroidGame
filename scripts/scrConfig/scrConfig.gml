// scrConfig: constantes del juego. Cambia los valores aquí para ajustar la jugabilidad.

// --- Pantalla ---
#macro RES_ANCHO 1280               // ancho lógico de las salas (16:9)
#macro RES_ALTO 720                 // alto lógico de las salas

// --- Jugador ---
#macro JUGADOR_ACELERACION 0.1      // empuje por frame al avanzar
#macro JUGADOR_ACELERACION_ATRAS 0.05 // empuje por frame al ir hacia atrás (más suave)
#macro JUGADOR_VEL_MAX 6            // velocidad máxima de la nave
#macro JUGADOR_FRICCION 0.03        // desaceleración por frame
#macro JUGADOR_GIRO 1.5               // grados que gira por frame
#macro JUGADOR_CADENCIA 12          // frames entre disparos (60 fps -> 5 por segundo)

// --- Bala ---
#macro BALA_VELOCIDAD 12            // velocidad de la bala
#macro BALA_DISTANCIA_PUNTA 32      // distancia del centro de la nave a su punta

// --- Rocas ---
#macro ROCA_VELOCIDAD 2             // velocidad base de una roca
#macro ROCA_GIRO 1                  // grados que gira la roca por frame
#macro ROCA_MARGEN_WRAP 70          // margen para reaparecer al salir de la pantalla

// --- Menú ---
#macro MENU_BOTON_ANCHO 320         // ancho de cada botón
#macro MENU_BOTON_ALTO 70           // alto de cada botón
#macro MENU_BOTON_SEPARACION 24     // espacio entre botones

// --- Partida y puntaje ---
#macro VIDAS_INICIALES 3            // vidas al empezar una partida
#macro PUNTOS_ROCA_GRANDE 20        // puntos al partir una roca grande
#macro PUNTOS_ROCA_PEQUENA 50       // puntos al destruir una roca pequeña

// --- HUD ---
#macro HUD_MARGEN 20                // separación del HUD con el borde de la pantalla

// --- Tiempo ---
#macro FPS_JUEGO 60                          // fotogramas por segundo (igual que Game Options)

// --- Vidas y game over ---
#macro JUGADOR_INVULNERABILIDAD (3 * FPS_JUEGO)  // frames sin daño tras perder una vida (3 s)
#macro JUGADOR_PARPADEO 8                    // frames por ciclo de parpadeo al ser invulnerable
#macro GAMEOVER_ESPERA (6 * FPS_JUEGO)       // frames antes de volver solo al menú (6 s)
#macro GAMEOVER_GRACIA (FPS_JUEGO / 2)       // frames antes de permitir saltar la pantalla

// --- Niveles ---
#macro NIVELES_TOTAL 10                      // niveles hasta la victoria
#macro ROCAS_BASE 2                          // rocas grandes del nivel 1
#macro ROCAS_NIVELES_POR_EXTRA 2             // cada cuántos niveles se suma una roca grande más
#macro ROCA_VELOCIDAD_POR_NIVEL 0.25         // velocidad extra de las rocas por cada nivel
#macro ROCA_DISTANCIA_MIN_NAVE 250           // distancia mínima entre la nave y las rocas al empezar
#macro NIVEL_INTRO (2 * FPS_JUEGO)           // frames del cartel "NIVEL N" (la nave es invulnerable)
#macro NIVEL_PAUSA_FIN (2 * FPS_JUEGO)       // frames de pausa tras limpiar el nivel

// --- Tipos de roca ---
#macro ROCA_NORMAL 0
#macro ROCA_RAPIDA 1                         // naranja, más veloz
#macro ROCA_RESISTENTE 2                     // celeste, aguanta varios disparos
#macro ROCA_RAPIDA_FACTOR 1.6                // multiplicador de velocidad de la roca rápida
#macro ROCA_RESISTENTE_VIDA 2                // disparos que aguanta la roca resistente grande
#macro NIVEL_MIN_RAPIDA 3                    // primer nivel con rocas rápidas
#macro NIVEL_MIN_RESISTENTE 5                // primer nivel con rocas resistentes
#macro PROB_TIPO_POR_NIVEL 0.1               // probabilidad extra de cada tipo por nivel desde su primer nivel
#macro PROB_TIPO_MAX 0.4                     // probabilidad máxima de cada tipo

// Estados de un nivel
enum eEstadoNivel {
	INTRO,
	JUGANDO,
	COMPLETADO
}

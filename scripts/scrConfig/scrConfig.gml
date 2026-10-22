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

// Opciones del menú principal
#macro MENU_JUGAR 0                 // empezar la partida
#macro MENU_MODO 1                  // cambiar entre 1 y 2 jugadores
#macro MENU_PUNTAJES 2              // ver los mejores puntajes
#macro MENU_SALIR 3                 // cerrar el juego
#macro MENU_Y_INICIO 0.4            // altura del primer botón (fracción de la altura de la sala)

// --- Modo de juego ---
#macro MODO_1J 1                    // un jugador
#macro MODO_2J 2                    // dos jugadores en la misma partida (vidas compartidas)

// --- Multijugador ---
#macro JUGADOR_2_DESPLAZAMIENTO_X 170  // separación de las dos naves respecto al centro

// --- Colores de los jugadores ---
#macro COLOR_JUGADOR_1 make_colour_rgb(255, 255, 255)   // blanco
#macro COLOR_JUGADOR_2 make_colour_rgb(140, 200, 255)   // celeste, para distinguir las naves

// --- Partida y puntaje ---
#macro VIDAS_INICIALES 3            // vidas al empezar una partida de 1 jugador
#macro VIDAS_INICIALES_2J 5         // vidas compartidas al empezar una partida de 2 jugadores
#macro PUNTOS_ROCA_GRANDE 20        // puntos al partir una roca grande
#macro PUNTOS_ROCA_PEQUENA 50       // puntos al destruir una roca pequeña

// --- HUD ---
#macro HUD_MARGEN 20                // separación del HUD con el borde de la pantalla

// --- Tiempo ---
#macro FPS_JUEGO 60                          // fotogramas por segundo (igual que Game Options)

// --- Vidas y game over ---
#macro JUGADOR_INVULNERABILIDAD (3 * FPS_JUEGO)  // frames sin daño tras perder una vida (3 s)
#macro JUGADOR_PARPADEO 8                    // frames por ciclo de parpadeo al ser invulnerable
#macro GAMEOVER_GRACIA (FPS_JUEGO / 2)       // frames antes de permitir saltar la pantalla

// --- Niveles ---
#macro NIVELES_TOTAL 10                      // niveles hasta la victoria
#macro ROCAS_BASE 2                          // rocas grandes del nivel 1
#macro ROCAS_NIVELES_POR_EXTRA 2             // cada cuántos niveles se suma una roca grande más
#macro ROCAS_BASE_2J 3                       // rocas grandes del nivel 1 con 2 jugadores
#macro ROCAS_POR_NIVEL_2J 0.6                // rocas grandes extra por nivel con 2 jugadores (llega a 9 en el nivel 10)
#macro ROCA_VELOCIDAD_POR_NIVEL 0.25         // velocidad extra de las rocas por cada nivel
#macro ROCA_DISTANCIA_MIN_NAVE 250           // distancia mínima entre la nave y las rocas al empezar
#macro NIVEL_INTRO (2 * FPS_JUEGO)           // frames del cartel "NIVEL N" (la nave es invulnerable)
#macro NIVEL_PAUSA_FIN (3 * FPS_JUEGO)       // frames de pausa tras limpiar el nivel (se ve el tiempo y el bono)

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
	COMPLETADO,
	PERDIDO
}

// --- Explosión de la nave ---
#macro EXPLOSION_PARTICULAS 18               // fragmentos que salen despedidos
#macro EXPLOSION_VEL_MIN 1.5                 // velocidad mínima de un fragmento
#macro EXPLOSION_VEL_MAX 5                   // velocidad máxima de un fragmento
#macro EXPLOSION_FRICCION 0.96               // los fragmentos frenan multiplicando su velocidad por este valor
#macro EXPLOSION_LARGO_MIN 6                 // largo mínimo de un fragmento (px)
#macro EXPLOSION_LARGO_MAX 14                // largo máximo de un fragmento (px)
#macro EXPLOSION_GIRO_MAX 8                  // giro máximo de un fragmento por frame (grados)
#macro EXPLOSION_ONDA_VEL 2.5                // crecimiento de la onda expansiva por frame (px)
#macro EXPLOSION_DURACION (1 * FPS_JUEGO)    // frames que dura la explosión (1 s)
#macro PERDIDO_ESPERA (1.5 * FPS_JUEGO)      // frames entre la última explosión y el game over

// --- Ayudas (power-ups) ---
#macro AYUDA_ESCUDO 0
#macro AYUDA_MULTI 1
#macro AYUDA_DANO 2
#macro AYUDA_VIDA 3                          // vida extra (efecto inmediato, sin duración)
#macro AYUDA_TIPOS_TEMPORALES 3              // tipos de ayuda con duración (0, 1 y 2)
#macro COLOR_AYUDA_ESCUDO make_colour_rgb(70, 150, 255)   // azul
#macro COLOR_AYUDA_MULTI make_colour_rgb(80, 220, 110)    // verde
#macro COLOR_AYUDA_DANO make_colour_rgb(255, 70, 70)      // rojo
#macro COLOR_AYUDA_VIDA make_colour_rgb(255, 215, 60)     // amarillo
#macro VIDAS_MAX 5                           // máximo de vidas acumuladas con 1 jugador
#macro VIDAS_MAX_2J 7                        // máximo de vidas acumuladas con 2 jugadores
#macro AYUDA_PROB_VIDA 0.2                   // probabilidad de que una aparición sea vida extra (si se puede)
#macro AYUDA_DURACION (10 * FPS_JUEGO)       // frames que dura cada ayuda al recogerla (10 s)
#macro AYUDA_ESPERA_MIN (5 * FPS_JUEGO)      // espera mínima entre apariciones (5 s)
#macro AYUDA_ESPERA_MAX (12 * FPS_JUEGO)     // espera máxima entre apariciones (12 s)
#macro AYUDA_VIDA_PANTALLA (12 * FPS_JUEGO)  // frames que una ayuda flota antes de desaparecer
#macro AYUDA_PARPADEO_INICIO (3 * FPS_JUEGO) // frames finales en los que parpadea (ayuda flotante y escudo)
#macro AYUDA_VELOCIDAD 0.6                   // velocidad con la que flota
#macro AYUDA_RADIO 30                        // radio del aro que late alrededor de la ayuda
#macro AYUDA_MARGEN_SALA 80                  // distancia mínima a los bordes al aparecer
#macro AYUDA_DISTANCIA_MIN_NAVE 150          // distancia mínima a la nave al aparecer
#macro MULTI_ANGULO 18                       // ángulo entre las balas del disparo múltiple (grados)
#macro ESCUDO_ROMPE_INVULN (0.5 * FPS_JUEGO) // frames de invulnerabilidad tras romperse el escudo

// --- HUD de ayudas activas ---
#macro HUD_AYUDA_Y0 100                      // altura de la primera fila, bajo el margen del HUD
#macro HUD_AYUDA_FILA 36                     // separación vertical entre filas
#macro HUD_AYUDA_BARRA_ANCHO 140             // ancho de la barra de tiempo
#macro HUD_AYUDA_BARRA_ALTO 8                // alto de la barra de tiempo

// --- Bono por tiempo al completar un nivel ---
#macro BONO_TIEMPO_1 15                      // segundos del nivel 1 para el bono máximo (menos de 1 min)
#macro BONO_TIEMPO_2 30                      // segundos del nivel 1 para el segundo bono (menos de 2 min)
#macro BONO_TIEMPO_3 60                      // segundos del nivel 1 para el tercer bono (menos de 4 min)
#macro BONO_PUNTOS_1 500                     // puntos extra del primer tramo
#macro BONO_PUNTOS_2 200                     // puntos extra del segundo tramo
#macro BONO_PUNTOS_3 100                     // puntos extra del tercer tramo
#macro BONO_CRECIMIENTO_NIVEL 0.1            // los límites de tiempo crecen este % por cada nivel (0.1 = 10 %)

// --- Mejores puntajes (tops) ---
#macro TOP_MAX 10                            // puestos de cada top
#macro TOP_ARCHIVO "puntajes.ini"            // archivo de guardado (en la carpeta de guardado del juego)
#macro NOMBRE_MAX 12                         // letras máximas de un nombre
#macro NOMBRE_INACTIVIDAD (30 * FPS_JUEGO)   // frames sin tocar nada antes de guardar solo con nombre genérico (30 s)
#macro TOP_ESPERA_LISTA (12 * FPS_JUEGO)     // frames que se ve la lista antes de volver al menú (12 s)
#macro TOPS_ANCHO 520                        // ancho de la lista del top
#macro TOPS_FILA 34                          // alto de cada fila de la lista

// Fases de la pantalla final
enum eFaseFinal {
	NOMBRE,
	LISTA
}

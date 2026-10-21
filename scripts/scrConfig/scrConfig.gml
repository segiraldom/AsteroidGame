// scrConfig: constantes del juego. Cambia los valores aquí para ajustar la jugabilidad.

// --- Pantalla ---
#macro RES_ANCHO 1280               // ancho lógico de las salas (16:9)
#macro RES_ALTO 720                 // alto lógico de las salas

// --- Jugador ---
#macro JUGADOR_ACELERACION 0.1      // empuje por frame al avanzar
#macro JUGADOR_VEL_MAX 6            // velocidad máxima de la nave
#macro JUGADOR_FRICCION 0.03        // desaceleración por frame
#macro JUGADOR_GIRO 1               // grados que gira por frame
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

// Música del menú en la pantalla final
scrMusica(MUSICA_MENU);

// Dibujar por encima de todo
depth = -100;

// Frames transcurridos en esta pantalla
tiempo = 0;

// Título según cómo terminó la partida
titulo = global.victoria ? "¡VICTORIA!" : "GAME OVER";

// Modo jugado y puesto que ocupa el puntaje en su top (-1 si no entra)
modo = scrMultijugador() ? MODO_2J : MODO_1J;
puesto = scrTopsPosicion(modo, global.puntaje);

// Fase 1: escribir el nombre (solo si entra al top). Fase 2: ver la lista.
fase = (puesto >= 0) ? eFaseFinal.NOMBRE : eFaseFinal.LISTA;
resaltado = -1;      // fila de la lista que se resalta
inactividad = 0;     // frames sin tocar ninguna tecla (fase del nombre)
tiempo_lista = 0;    // frames en la fase de la lista

// Empieza con el campo de texto vacío
keyboard_string = "";

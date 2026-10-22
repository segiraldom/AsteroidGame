// La pausa solo existe durante la partida; en el menú siempre está apagada
global.pausa = false;

// Música del menú (sigue sonando si ya estaba)
scrMusica(MUSICA_MENU);

// Dibujar por encima de las rocas decorativas
depth = -100;

opciones = [MENU_JUGAR, MENU_MODO, MENU_PUNTAJES, MENU_SALIR];
seleccion = MENU_JUGAR;

// El modo elegido se queda guardado entre partidas
if !variable_global_exists("modo"){
	global.modo = MODO_1J;
}

// Para detectar si el ratón se movió (así el teclado y el ratón no se pelean)
mouse_previo_x = mouse_x;
mouse_previo_y = mouse_y;

// Rectángulo de cada botón, centrado en la sala
botones = [];
for (var i = 0; i < array_length(opciones); i++){
	var _x1 = room_width / 2 - MENU_BOTON_ANCHO / 2;
	var _y1 = room_height * MENU_Y_INICIO + i * (MENU_BOTON_ALTO + MENU_BOTON_SEPARACION);
	array_push(botones, {
		x1: _x1,
		y1: _y1,
		x2: _x1 + MENU_BOTON_ANCHO,
		y2: _y1 + MENU_BOTON_ALTO
	});
}

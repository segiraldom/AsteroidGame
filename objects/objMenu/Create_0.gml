// Dibujar por encima de las rocas decorativas
depth = -100;

opciones = ["JUGAR", "SALIR"];
seleccion = 0;

// Para detectar si el ratón se movió (así el teclado y el ratón no se pelean)
mouse_previo_x = mouse_x;
mouse_previo_y = mouse_y;

// Rectángulo de cada botón, centrado en la sala
botones = [];
for (var i = 0; i < array_length(opciones); i++){
	var _x1 = room_width / 2 - MENU_BOTON_ANCHO / 2;
	var _y1 = room_height * 0.55 + i * (MENU_BOTON_ALTO + MENU_BOTON_SEPARACION);
	array_push(botones, {
		x1: _x1,
		y1: _y1,
		x2: _x1 + MENU_BOTON_ANCHO,
		y2: _y1 + MENU_BOTON_ALTO
	});
}

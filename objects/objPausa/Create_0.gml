// Por encima del HUD y de todo lo demás
depth = -200;

seleccion = PAUSA_CONTINUAR;
// Opción que espera confirmación (-1 = ninguna)
confirmar = -1;

// Para detectar si el ratón se movió (así el teclado y el ratón no se pelean)
mouse_previo_x = mouse_x;
mouse_previo_y = mouse_y;

// Botones de la lista, centrados en la sala
botones = [];
for (var i = 0; i < PAUSA_TOTAL; i++){
	var _x1 = room_width / 2 - PAUSA_BOTON_ANCHO / 2;
	var _y1 = room_height * PAUSA_Y_INICIO + i * (PAUSA_BOTON_ALTO + PAUSA_BOTON_SEPARACION);
	array_push(botones, {
		x1: _x1,
		y1: _y1,
		x2: _x1 + PAUSA_BOTON_ANCHO,
		y2: _y1 + PAUSA_BOTON_ALTO
	});
}

// Botones de la confirmación: SÍ (0) a la izquierda y NO (1) a la derecha
botones_conf = [];
for (var i = 0; i < 2; i++){
	var _cx1 = room_width / 2 - 215 + i * 230;
	var _cy1 = room_height * 0.5;
	array_push(botones_conf, {
		x1: _cx1,
		y1: _cy1,
		x2: _cx1 + 200,
		y2: _cy1 + PAUSA_BOTON_ALTO
	});
}

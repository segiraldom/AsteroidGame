draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

// Título y ayuda de controles
draw_text_transformed(room_width / 2, room_height * 0.25, "ASTEROID GAME", 4, 4, 0);
draw_text_transformed(room_width / 2, room_height - 40, "Mover: flechas / WASD   |   Disparar: clic / Espacio   |   Pantalla completa: F11", 1.3, 1.3, 0);

// Botones
for (var i = 0; i < array_length(opciones); i++){
	var _b = botones[i];
	var _cx = (_b.x1 + _b.x2) / 2;
	var _cy = (_b.y1 + _b.y2) / 2;
	if i == seleccion{
		// Seleccionado: relleno blanco, texto negro
		draw_set_color(c_white);
		draw_rectangle(_b.x1, _b.y1, _b.x2, _b.y2, false);
		draw_set_color(c_black);
	}else{
		// Normal: solo borde, texto blanco
		draw_set_color(c_white);
		draw_rectangle(_b.x1, _b.y1, _b.x2, _b.y2, true);
	}
	draw_text_transformed(_cx, _cy, opciones[i], 2, 2, 0);
}

// Restaurar valores por defecto
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

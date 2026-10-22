draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

var _cx = room_width / 2;

draw_text_transformed(_cx, room_height * 0.14, titulo, 5, 5, 0);
draw_text_transformed(_cx, room_height * 0.26, "PUNTAJE FINAL: " + string(global.puntaje), 2.5, 2.5, 0);

if fase == eFaseFinal.NOMBRE{
	// Entró al top: se pide el nombre
	draw_text_transformed(_cx, room_height * 0.42, "¡ENTRASTE AL TOP 10!  PUESTO " + string(puesto + 1), 2, 2, 0);
	draw_text_transformed(_cx, room_height * 0.52, (modo == MODO_2J) ? "NOMBRE DEL EQUIPO:" : "ESCRIBE TU NOMBRE:", 2, 2, 0);

	// Campo de texto
	var _x1 = _cx - 260;
	var _x2 = _cx + 260;
	var _y1 = room_height * 0.58;
	var _y2 = _y1 + 60;
	var _ym = (_y1 + _y2) / 2;
	draw_rectangle(_x1, _y1, _x2, _y2, true);

	draw_set_halign(fa_left);
	draw_text_transformed(_x1 + 16, _ym, keyboard_string, 2.5, 2.5, 0);
	// Cursor que parpadea
	if (tiempo div 30) mod 2 == 0{
		var _xc = _x1 + 16 + string_width(keyboard_string) * 2.5 + 4;
		draw_line(_xc, _ym - 20, _xc, _ym + 20);
	}
	draw_set_halign(fa_center);

	draw_text_transformed(_cx, room_height * 0.74, "Enter para confirmar   |   vacío = " + scrNombreGenerico(modo, false), 1.5, 1.5, 0);
	var _segundos = ceil((NOMBRE_INACTIVIDAD - inactividad) / FPS_JUEGO);
	draw_text_transformed(_cx, room_height * 0.80, "Si no tocas nada se guarda solo en " + string(_segundos) + " s", 1.3, 1.3, 0);
}else{
	// Lista del top del modo jugado
	if puesto >= 0{
		draw_text_transformed(_cx, room_height * 0.31, "TU PUESTO: " + string(resaltado + 1), 1.5, 1.5, 0);
	}else{
		draw_text_transformed(_cx, room_height * 0.31, "No entraste al top 10 esta vez", 1.5, 1.5, 0);
	}
	scrDibujarTop(modo, _cx, room_height * 0.37, resaltado);

	var _seg_lista = ceil((TOP_ESPERA_LISTA - tiempo_lista) / FPS_JUEGO);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(_cx, room_height - 26, "Enter, Espacio o clic para volver al menú   |   Volviendo en " + string(_seg_lista) + "...", 1.3, 1.3, 0);
}

// Restaurar valores por defecto
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

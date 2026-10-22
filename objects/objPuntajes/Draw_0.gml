var _cx = room_width / 2;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

draw_text_transformed(_cx, room_height * 0.08, "MEJORES PUNTAJES", 3, 3, 0);

// Los dos tops lado a lado
scrDibujarTop(MODO_1J, room_width * 0.27, room_height * 0.20, -1);
scrDibujarTop(MODO_2J, room_width * 0.73, room_height * 0.20, -1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

if confirmando{
	// Cuadro de confirmación del borrado
	var _cy = room_height / 2;
	draw_set_color(c_black);
	draw_rectangle(_cx - 420, _cy - 70, _cx + 420, _cy + 70, false);
	draw_set_color(c_white);
	draw_rectangle(_cx - 420, _cy - 70, _cx + 420, _cy + 70, true);
	draw_text_transformed(_cx, _cy - 22, "¿BORRAR TODOS LOS PUNTAJES?", 2.5, 2.5, 0);
	draw_text_transformed(_cx, _cy + 30, "Enter = SÍ   |   Esc = NO", 1.8, 1.8, 0);
}else{
	draw_text_transformed(_cx, room_height - 30, "Esc, Enter o clic para volver al menú", 1.3, 1.3, 0);
}

// Restaurar valores por defecto
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

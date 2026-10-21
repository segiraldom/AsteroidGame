// HUD: puntaje (izquierda), nivel (centro) y vidas (derecha)
draw_set_color(c_white);
draw_set_valign(fa_top);

draw_set_halign(fa_left);
draw_text_transformed(HUD_MARGEN, HUD_MARGEN, "PUNTAJE: " + string(global.puntaje), 1.5, 1.5, 0);

draw_set_halign(fa_center);
draw_text_transformed(room_width / 2, HUD_MARGEN, "NIVEL: " + string(global.nivel), 1.5, 1.5, 0);

draw_set_halign(fa_right);
draw_text_transformed(room_width - HUD_MARGEN, HUD_MARGEN, "VIDAS: " + string(global.vidas), 1.5, 1.5, 0);

// Una miniatura de la nave por cada vida, debajo del texto
for (var i = 0; i < global.vidas; i++){
	draw_sprite_ext(sprPlayer, 0, room_width - HUD_MARGEN - 16 - i * 36, HUD_MARGEN + 56, 0.5, 0.5, 90, c_white, 1);
}

// Carteles del nivel
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if estado == eEstadoNivel.INTRO{
	draw_text_transformed(room_width / 2, room_height * 0.35, "NIVEL " + string(global.nivel), 4, 4, 0);
}else if estado == eEstadoNivel.COMPLETADO{
	draw_text_transformed(room_width / 2, room_height * 0.35, "NIVEL COMPLETADO", 3, 3, 0);
}

// Restaurar valores por defecto
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

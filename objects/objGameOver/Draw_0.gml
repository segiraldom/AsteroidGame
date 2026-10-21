draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

var _segundos = ceil((GAMEOVER_ESPERA - tiempo) / FPS_JUEGO);

draw_text_transformed(room_width / 2, room_height * 0.30, titulo, 5, 5, 0);
draw_text_transformed(room_width / 2, room_height * 0.50, "PUNTAJE FINAL: " + string(global.puntaje), 2.5, 2.5, 0);
draw_text_transformed(room_width / 2, room_height * 0.68, "Enter, Espacio o clic para volver al menú", 1.5, 1.5, 0);
draw_text_transformed(room_width / 2, room_height * 0.75, "Volviendo al menú en " + string(_segundos) + "...", 1.5, 1.5, 0);

// Restaurar valores por defecto
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

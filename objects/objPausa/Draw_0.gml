if !global.pausa{
	exit;
}

// Fondo oscuro sobre la partida congelada
draw_set_color(c_black);
draw_set_alpha(PAUSA_OSCURECER);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

var _lista = botones;
var _total = PAUSA_TOTAL;
if confirmar < 0{
	draw_text_transformed(room_width / 2, room_height * 0.17, "PAUSA", 4, 4, 0);
	draw_text_transformed(room_width / 2, room_height - 40, "ESC: continuar     W / S o flechas: elegir     ENTER: aceptar", 1.2, 1.2, 0);
}else{
	_lista = botones_conf;
	_total = 2;
	var _pregunta = (confirmar == PAUSA_MENU) ? "¿SALIR AL MENÚ?" : "¿SALIR DEL JUEGO?";
	draw_text_transformed(room_width / 2, room_height * 0.3, _pregunta, 3, 3, 0);
	draw_text_transformed(room_width / 2, room_height * 0.3 + 60, "Se perderá la partida actual", 1.5, 1.5, 0);
}

// Botones: el seleccionado va relleno en blanco
for (var i = 0; i < _total; i++){
	var _b = _lista[i];
	var _cx = (_b.x1 + _b.x2) / 2;
	var _cy = (_b.y1 + _b.y2) / 2;
	var _texto;
	if confirmar < 0{
		_texto = scrPausaTexto(i);
	}else{
		_texto = (i == 0) ? "SÍ" : "NO";
	}
	draw_set_color(c_white);
	if i == seleccion{
		draw_rectangle(_b.x1, _b.y1, _b.x2, _b.y2, false);
		draw_set_color(c_black);
	}else{
		draw_rectangle(_b.x1, _b.y1, _b.x2, _b.y2, true);
	}
	var _escala = min(1.8, (_b.x2 - _b.x1 - 40) / string_width(_texto));
	draw_text_transformed(_cx, _cy, _texto, _escala, _escala, 0);
}

// Restaurar valores por defecto
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

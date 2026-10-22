// HUD: puntaje (izquierda), nivel (centro) y vidas (derecha)
draw_set_color(c_white);
draw_set_valign(fa_top);

draw_set_halign(fa_left);
draw_text_transformed(HUD_MARGEN, HUD_MARGEN, "PUNTAJE: " + string(global.puntaje), 1.5, 1.5, 0);

// Tiempo del nivel y bono que se ganaría si se completara ahora
var _bono_actual = scrBonoTiempo(tiempo_nivel, global.nivel);
var _texto_bono = (_bono_actual > 0) ? "BONO +" + string(_bono_actual) : "SIN BONO";
draw_text_transformed(HUD_MARGEN, HUD_MARGEN + 36, "TIEMPO: " + scrFormatoTiempo(tiempo_nivel) + "   " + _texto_bono, 1.3, 1.3, 0);

draw_set_halign(fa_center);
draw_text_transformed(room_width / 2, HUD_MARGEN, "NIVEL: " + string(global.nivel), 1.5, 1.5, 0);

// En modo 2 jugadores se recuerda que las vidas son compartidas
if scrMultijugador(){
	draw_text_transformed(room_width / 2, HUD_MARGEN + 44, "MODO: " + scrModoNombre(), 1.3, 1.3, 0);
}

draw_set_halign(fa_right);
draw_text_transformed(room_width - HUD_MARGEN, HUD_MARGEN, "VIDAS: " + string(global.vidas), 1.5, 1.5, 0);

// Una miniatura de la nave por cada vida, debajo del texto
for (var i = 0; i < global.vidas; i++){
	draw_sprite_ext(sprPlayer, 0, room_width - HUD_MARGEN - 16 - i * 36, HUD_MARGEN + 56, 0.5, 0.5, 90, c_white, 1);
}

// Ayudas activas de cada nave: icono, nombre y barra con el tiempo restante
// (debajo de las vidas). En 2 jugadores cada fila indica a quién pertenece.
var _fila = 0;
with (objPlayer){
	var _prefijo = scrMultijugador() ? "J" + string(numero) + "  " : "";
	for (var _t = 0; _t < AYUDA_TIPOS_TEMPORALES; _t++){
		var _restante = scrAyudaTiempo(self, _t);
		if _restante > 0{
			var _color = scrAyudaColor(_t);
			var _yf = HUD_MARGEN + HUD_AYUDA_Y0 + _fila * HUD_AYUDA_FILA;
			var _xi = room_width - HUD_MARGEN - 20;
			var _xb2 = _xi - 30;
			var _xb1 = _xb2 - HUD_AYUDA_BARRA_ANCHO;
			draw_sprite_ext(scrAyudaSprite(_t), 0, _xi, _yf, 0.8, 0.8, 0, _color, 1);
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
			draw_set_color(_color);
			draw_text(_xb2, _yf - 2, _prefijo + scrAyudaNombre(_t));
			draw_rectangle(_xb1, _yf + 2, _xb2, _yf + 2 + HUD_AYUDA_BARRA_ALTO, true);
			draw_rectangle(_xb1, _yf + 2, _xb1 + HUD_AYUDA_BARRA_ANCHO * (_restante / AYUDA_DURACION), _yf + 2 + HUD_AYUDA_BARRA_ALTO, false);
			_fila += 1;
		}
	}
}
draw_set_color(c_white);

// Barra de vida del jefe
scrDibujarBarraJefe();

// Carteles del nivel
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if estado == eEstadoNivel.INTRO{
	draw_text_transformed(room_width / 2, room_height * 0.35, es_jefe ? "¡JEFE!" : "NIVEL " + string(global.nivel), 4, 4, 0);
}else if estado == eEstadoNivel.COMPLETADO{
	draw_text_transformed(room_width / 2, room_height * 0.35, "NIVEL COMPLETADO", 3, 3, 0);
	draw_text_transformed(room_width / 2, room_height * 0.35 + 70, "TIEMPO: " + scrFormatoTiempo(tiempo_nivel), 2, 2, 0);
	var _texto_final = (bono_nivel > 0) ? "BONO POR TIEMPO: +" + string(bono_nivel) : "SIN BONO POR TIEMPO";
	draw_text_transformed(room_width / 2, room_height * 0.35 + 115, _texto_final, 2, 2, 0);
}

// Restaurar valores por defecto
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

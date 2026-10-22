/// Funciones de los jefes

/// Indica si el nivel tiene jefe (por ahora solo el nivel 5; el del nivel 10 llega en el siguiente paso)
function scrEsNivelJefe(_nivel){
	return _nivel == NIVEL_JEFE_1;
}

/// Vida total del jefe de roca según el modo de juego
function scrJefeVidaMax(){
	if scrMultijugador(){
		return ceil(JEFE_ROCA_VIDA * JEFE_VIDA_FACTOR_2J);
	}
	return JEFE_ROCA_VIDA;
}

/// El jefe lanza rocas pequeñas hacia la nave más cercana:
/// 1 roca en las fases 1 y 3, 3 en abanico en la fase 2
function scrJefeEscupir(_jefe, _fase){
	var _objetivo = instance_nearest(_jefe.x, _jefe.y, objPlayer);
	if _objetivo == noone{
		return;
	}
	var _cantidad = (_fase == 2) ? 3 : 1;
	var _base = point_direction(_jefe.x, _jefe.y, _objetivo.x, _objetivo.y);
	for (var i = 0; i < _cantidad; i++){
		if instance_number(objRock) >= JEFE_MAX_LANZADAS{
			return;
		}
		var _desvio = (i - (_cantidad - 1) / 2) * JEFE_ABANICO;
		var _roca = instance_create_layer(_jefe.x, _jefe.y, "Instances", objRock);
		_roca.sprite_index = sprRockSmall;
		_roca.vida = 1;
		_roca.direction = _base + _desvio;
		_roca.speed = JEFE_VEL_LANZADA;
	}
}

/// Choque del jefe con una nave: quita una vida como una roca,
/// pero el escudo solo se rompe (no destruye al jefe)
function scrJefeGolpeaNave(_nave){
	with (_nave){
		if invulnerabilidad > 0 || global.vidas <= 0{
			exit;
		}
		if ayuda_escudo > 0{
			ayuda_escudo = 0;
			invulnerabilidad = ESCUDO_ROMPE_INVULN;
			exit;
		}
		global.vidas -= 1;
		ayuda_multi = 0;
		ayuda_dano = 0;
		instance_create_layer(x, y, "Instances", objExplosion);
		if global.vidas <= 0{
			instance_destroy();
		}else{
			invulnerabilidad = JUGADOR_INVULNERABILIDAD;
		}
	}
}

/// Derrota del jefe: puntos, explosiones y todas las rocas restantes explotan
function scrJefeDerrotado(_jefe){
	global.puntaje += JEFE_PUNTOS_DERROTA;
	var _ancho = _jefe.sprite_width / 2;
	var _alto = _jefe.sprite_height / 2;
	repeat (JEFE_EXPLOSIONES){
		instance_create_layer(_jefe.x + random_range(-_ancho, _ancho) * 0.7, _jefe.y + random_range(-_alto, _alto) * 0.7, "Instances", objExplosion);
	}
	with (objRock){
		instance_create_layer(x, y, "Instances", objExplosion);
		instance_destroy();
	}
	with (_jefe){
		instance_destroy();
	}
}

/// Barra de vida del jefe, arriba al centro (se llama desde el HUD de objGame)
function scrDibujarBarraJefe(){
	if !instance_exists(objJefeRoca){
		return;
	}
	var _jefe = instance_find(objJefeRoca, 0);
	var _x1 = room_width / 2 - JEFE_BARRA_ANCHO / 2;
	var _x2 = _x1 + JEFE_BARRA_ANCHO;
	var _y1 = JEFE_BARRA_Y;
	var _y2 = _y1 + JEFE_BARRA_ALTO;
	var _fraccion = clamp(_jefe.vida / _jefe.vida_max, 0, 1);

	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_color(c_white);
	draw_text(room_width / 2, _y1 - 4, "JEFE");
	draw_rectangle(_x1, _y1, _x2, _y2, true);
	draw_set_color(c_red);
	draw_rectangle(_x1, _y1, _x1 + JEFE_BARRA_ANCHO * _fraccion, _y2, false);
	draw_set_color(c_white);
}

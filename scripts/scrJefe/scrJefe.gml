/// Funciones de los jefes

/// Indica si el nivel tiene jefe (roca gigante en el 5, pulpo alienígena en el 10)
function scrEsNivelJefe(_nivel){
	return _nivel == NIVEL_JEFE_1 || _nivel == NIVEL_JEFE_2;
}

/// Indica si hay algún jefe en pantalla (para saber cuándo se completa el nivel)
function scrExisteJefe(){
	return instance_exists(objJefeRoca) || instance_exists(objJefePulpo);
}

/// Vida base del jefe del nivel actual (roca gigante o pulpo)
function scrJefeVidaBase(){
	if global.nivel == NIVEL_JEFE_2{
		return PULPO_VIDA;
	}
	return JEFE_ROCA_VIDA;
}

/// Vida total del jefe según el modo de juego
function scrJefeVidaMax(){
	if scrMultijugador(){
		return ceil(scrJefeVidaBase() * JEFE_VIDA_FACTOR_2J);
	}
	return scrJefeVidaBase();
}

/// El jefe lanza rocas pequeñas hacia la nave más cercana.
/// La cantidad de rocas la decide cada jefe según su fase; el abanico, la
/// velocidad y el máximo de rocas los define cada jefe en su Create.
function scrJefeEscupir(_jefe, _fase, _cantidad){
	var _objetivo = instance_nearest(_jefe.x, _jefe.y, objPlayer);
	if _objetivo == noone{
		return;
	}
	var _base = point_direction(_jefe.x, _jefe.y, _objetivo.x, _objetivo.y);
	for (var i = 0; i < _cantidad; i++){
		if instance_number(objRock) >= _jefe.max_lanzadas{
			return;
		}
		var _desvio = (i - (_cantidad - 1) / 2) * _jefe.abanico;
		var _roca = instance_create_layer(_jefe.x, _jefe.y, "Instances", objRock);
		_roca.sprite_index = sprRockSmall;
		_roca.vida = 1;
		_roca.direction = _base + _desvio;
		_roca.speed = _jefe.vel_lanzada;
	}
}

/// Color del pulpo según su fase (lo usan su dibujo y sus lasers)
function scrPulpoColor(_fase){
	if _fase == 2{
		return make_colour_rgb(190, 90, 235);
	}else if _fase == 3{
		return make_colour_rgb(235, 120, 255);
	}
	return make_colour_rgb(150, 70, 200);
}

/// El pulpo dispara lasers desde los ojos hacia las naves.
/// Alterna un ojo y el otro; con 2 jugadores apunta uno a cada nave.
function scrPulpoLanzarLasers(_pulpo, _cantidad){
	var _naves = instance_number(objPlayer);
	if _naves <= 0{
		return;
	}
	var _ojo_x = _pulpo.sprite_width * PULPO_LASER_OJO_X;
	var _ojo_y = _pulpo.sprite_height * PULPO_LASER_OJO_Y;
	for (var i = 0; i < _cantidad; i++){
		var _objetivo = instance_find(objPlayer, i % _naves);
		// Un laser de cada ojo, alternando
		var _lado = (i % 2 == 0) ? -1 : 1;
		var _lx = _pulpo.x + _lado * _ojo_x;
		var _ly = _pulpo.y - _ojo_y;
		var _laser = instance_create_layer(_lx, _ly, "Instances", objLaser);
		_laser.direction = point_direction(_lx, _ly, _objetivo.x, _objetivo.y);
		_laser.image_angle = _laser.direction;
		_laser.image_blend = scrPulpoColor(_pulpo.fase);
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
			scrSonido(sndChoque, VOL_CHOQUE);
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

/// Derrota del jefe: puntos, explosiones y todas las rocas restantes explotan.
/// Cada jefe pasa sus propios puntos y cantidad de explosiones.
function scrJefeDerrotado(_jefe, _puntos, _explosiones){
	global.puntaje += _puntos;
	var _ancho = _jefe.sprite_width / 2;
	var _alto = _jefe.sprite_height / 2;
	repeat (_explosiones){
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
	if !scrExisteJefe(){
		return;
	}
	var _jefe = instance_exists(objJefeRoca) ? instance_find(objJefeRoca, 0) : instance_find(objJefePulpo, 0);
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

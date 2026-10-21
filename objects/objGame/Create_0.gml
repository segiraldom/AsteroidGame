// Dibujar el HUD por encima de todo
depth = -100;

// Si se abre Room1 directamente (sin pasar por el menú), crear las variables globales
if !variable_global_exists("puntaje"){
	scrIniciarPartida();
}

// Quitar las rocas colocadas a mano en la sala: las rocas las genera el nivel
with (objRock){
	instance_destroy();
}

// Generar las rocas del nivel, lejos de la nave
var _cantidad = ROCAS_BASE + floor(global.nivel / ROCAS_NIVELES_POR_EXTRA);
var _centro_x = room_width / 2;
var _centro_y = room_height / 2;

// Probabilidad de cada tipo especial según el nivel
var _prob_rapida = 0;
if global.nivel >= NIVEL_MIN_RAPIDA{
	_prob_rapida = min(PROB_TIPO_MAX, (global.nivel - NIVEL_MIN_RAPIDA + 1) * PROB_TIPO_POR_NIVEL);
}
var _prob_resistente = 0;
if global.nivel >= NIVEL_MIN_RESISTENTE{
	_prob_resistente = min(PROB_TIPO_MAX, (global.nivel - NIVEL_MIN_RESISTENTE + 1) * PROB_TIPO_POR_NIVEL);
}

repeat (_cantidad){
	var _x, _y;
	do {
		_x = random(room_width);
		_y = random(room_height);
	} until (point_distance(_x, _y, _centro_x, _centro_y) > ROCA_DISTANCIA_MIN_NAVE);

	var _roca = instance_create_layer(_x, _y, "Instances", objRock);

	var _sorteo = random(1);
	if _sorteo < _prob_resistente{
		scrAplicarTipoRoca(_roca, ROCA_RESISTENTE);
	}else if _sorteo < _prob_resistente + _prob_rapida{
		scrAplicarTipoRoca(_roca, ROCA_RAPIDA);
	}
}

// Colocar la nave en el centro, mirando hacia arriba
if instance_exists(objPlayer){
	objPlayer.x = _centro_x;
	objPlayer.y = _centro_y;
	objPlayer.speed = 0;
	objPlayer.image_angle = 90;
}

// Empieza con el cartel de "NIVEL N"
estado = eEstadoNivel.INTRO;
temporizador = NIVEL_INTRO;

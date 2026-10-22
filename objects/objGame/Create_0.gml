// Dibujar el HUD por encima de todo
depth = -100;

// Si se abre Room1 directamente (sin pasar por el menú), crear las variables globales
if !variable_global_exists("puntaje"){
	scrIniciarPartida();
}

// Modo de juego por defecto si se abre la sala sin pasar por el menú
if !variable_global_exists("modo"){
	global.modo = MODO_1J;
}

// Quitar las rocas colocadas a mano en la sala: las rocas las genera el nivel
with (objRock){
	instance_destroy();
}

// En los niveles de jefe no hay rocas normales: solo el jefe
es_jefe = scrEsNivelJefe(global.nivel);

// Generar las rocas del nivel, lejos de la nave
var _cantidad = es_jefe ? 0 : scrCantidadRocas(global.nivel);
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

// Jefe del nivel 5
if es_jefe{
	instance_create_layer(_centro_x, JEFE_Y_INICIO, "Instances", objJefeRoca);
}

// Colocar las naves en el centro, mirando hacia arriba.
// En modo 2 jugadores van una a cada lado para que no se estorben al empezar.
var _separacion = scrMultijugador() ? JUGADOR_2_DESPLAZAMIENTO_X : 0;
// En nivel de jefe las naves empiezan abajo, lejos del jefe
var _nave_y = es_jefe ? room_height - JEFE_NAVE_Y_BORDE : _centro_y;
if instance_exists(objPlayer){
	objPlayer.x = _centro_x - _separacion;
	objPlayer.y = _nave_y;
	objPlayer.speed = 0;
	objPlayer.image_angle = 90;
}

// Segunda nave del modo 2 jugadores
if scrMultijugador(){
	var _p2 = instance_create_layer(_centro_x + _separacion, _nave_y, "Instances", objPlayer);
	scrConfigurarJugador(_p2, 2);
	// Mira hacia arriba, igual que la primera nave
	_p2.image_angle = 90;
}

// Puntaje y vidas con que empieza el nivel: es lo que se restaura al reiniciarlo desde la pausa
// (así reiniciar no sirve para acumular puntos)
global.puntaje_nivel = global.puntaje;
global.vidas_nivel = global.vidas;

// Menú de pausa (Esc)
global.pausa = false;
instance_create_layer(0, 0, "Instances", objPausa);

// Empieza con el cartel de "NIVEL N"
estado = eEstadoNivel.INTRO;
temporizador = NIVEL_INTRO;

// Frames que faltan para que aparezca la siguiente ayuda
ayuda_espera = irandom_range(AYUDA_ESPERA_MIN, AYUDA_ESPERA_MAX);

// Solo puede aparecer una vida extra por nivel
vida_extra_lanzada = false;

// Cronómetro del nivel (frames jugados) y bono ganado al completarlo
tiempo_nivel = 0;
bono_nivel = 0;

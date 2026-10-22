/// Funciones de sonido y música

/// Reproduce un efecto de sonido (prioridad alta para que la música no lo corte)
function scrSonido(_sonido, _volumen){
	return audio_play_sound(_sonido, PRIORIDAD_EFECTO, false, _volumen);
}

/// Sonido de clic de los botones
function scrClic(){
	scrSonido(sndClic, VOL_CLIC);
}

/// Sonido de explosión. Si varias explotan a la vez (jefe derrotado) solo suena una,
/// para que no se amontonen y distorsionen.
function scrSonidoExplosion(){
	if !variable_global_exists("explosion_ultima"){
		global.explosion_ultima = -1000;
	}
	if current_time - global.explosion_ultima < EXPLOSION_SONIDO_ESPERA{
		return;
	}
	global.explosion_ultima = current_time;
	scrSonido(sndExplosion, VOL_EXPLOSION);
}

/// Elige al azar una pista de batalla distinta a la que acaba de sonar
function scrBatallaElegir(){
	var _pistas = [sndBatalla1, sndBatalla2, sndBatalla3];
	if !variable_global_exists("batalla_anterior"){
		global.batalla_anterior = -1;
	}
	var _indice;
	do {
		_indice = irandom(array_length(_pistas) - 1);
	} until (_indice != global.batalla_anterior);
	global.batalla_anterior = _indice;
	return _pistas[_indice];
}

/// Detiene la música actual (si hay)
function scrDetenerMusica(){
	if variable_global_exists("musica"){
		audio_stop_sound(global.musica);
	}
	global.musica = -1;
	global.musica_tipo = MUSICA_NINGUNA;
}

/// Pone la música de un tipo (MUSICA_MENU, MUSICA_BATALLA o MUSICA_JEFE).
/// Si ya suena ese tipo no se reinicia, así sigue sonando al cambiar de sala.
function scrMusica(_tipo){
	if variable_global_exists("musica_tipo") && global.musica_tipo == _tipo && audio_is_playing(global.musica){
		return;
	}
	scrDetenerMusica();
	var _sonido, _volumen, _bucle;
	switch (_tipo){
		case MUSICA_MENU:
			_sonido = sndMenu;
			_volumen = VOL_MUSICA_MENU;
			_bucle = true;
			break;
		case MUSICA_JEFE:
			_sonido = sndBoos1;
			_volumen = VOL_MUSICA_JEFE;
			_bucle = true;
			break;
		default:
			// Batalla: pasa de una pista a otra al terminar (ver scrMusicaActualizar)
			_sonido = scrBatallaElegir();
			_volumen = VOL_MUSICA_BATALLA;
			_bucle = false;
			break;
	}
	global.musica = audio_play_sound(_sonido, PRIORIDAD_MUSICA, _bucle, _volumen);
	global.musica_tipo = _tipo;
}

/// Cuando termina una pista de batalla, empieza otra distinta (se llama cada frame en el nivel)
function scrMusicaActualizar(){
	if variable_global_exists("musica_tipo") && global.musica_tipo == MUSICA_BATALLA && !audio_is_playing(global.musica){
		global.musica_tipo = MUSICA_NINGUNA;
		scrMusica(MUSICA_BATALLA);
	}
}

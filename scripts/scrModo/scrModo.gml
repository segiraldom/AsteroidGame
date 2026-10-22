/// Modo de juego: un jugador o dos jugadores en la misma partida

/// true si la partida es a dos jugadores
/// (comprueba que la variable exista, por si se abre la sala sin pasar por el menú)
function scrMultijugador(){
	return variable_global_exists("modo") && global.modo == MODO_2J;
}

/// Cambia entre el modo de un jugador y el de dos
function scrAlternarModo(){
	global.modo = (global.modo == MODO_2J) ? MODO_1J : MODO_2J;
}

/// Nombre del modo actual, para el menú y el HUD
function scrModoNombre(){
	return scrMultijugador() ? "2 JUGADORES" : "1 JUGADOR";
}

/// Texto que se muestra en cada opción del menú
function scrMenuTexto(_opcion){
	switch (_opcion){
		case MENU_MODO: return "MODO DE JUEGO: " + scrModoNombre();
		case MENU_SALIR: return "SALIR";
	}
	return "JUGAR";
}

/// Ayuda de controles del menú, según el modo elegido
function scrControlesAyuda(){
	var _pantalla = "Pantalla completa: F11";
	if scrMultijugador(){
		return "J1: W A S D + Espacio   |   J2: flechas + Enter   |   " + _pantalla;
	}
	return "Mover: flechas / WASD   |   Disparar: clic / Espacio   |   " + _pantalla;
}

/// Vidas con las que empieza una partida (en 2 jugadores son compartidas)
function scrVidasIniciales(){
	return scrMultijugador() ? VIDAS_INICIALES_2J : VIDAS_INICIALES;
}

/// Máximo de vidas que se pueden acumular
function scrVidasMax(){
	return scrMultijugador() ? VIDAS_MAX_2J : VIDAS_MAX;
}

/// Rocas grandes que tiene un nivel (con 2 jugadores hay más)
function scrCantidadRocas(_nivel){
	if scrMultijugador(){
		return ROCAS_BASE_2J + floor(_nivel * ROCAS_POR_NIVEL_2J);
	}
	return ROCAS_BASE + floor(_nivel / ROCAS_NIVELES_POR_EXTRA);
}

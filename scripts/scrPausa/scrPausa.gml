/// Funciones del menú de pausa

/// Congela la partida: las naves, rocas, balas, ayudas y jefes dejan de moverse.
/// Las velocidades se guardan para devolverlas al reanudar.
function scrPausar(){
	global.pausa = true;
	with (all){
		if speed != 0{
			pausa_vel = speed;
			speed = 0;
		}
	}
}

/// Reanuda la partida y devuelve las velocidades guardadas
function scrReanudar(){
	with (all){
		// pausa_vel = 0 significa "nada guardado"
		if variable_instance_exists(id, "pausa_vel") && pausa_vel != 0{
			speed = pausa_vel;
			pausa_vel = 0;
		}
	}
	global.pausa = false;
}

/// Texto de cada opción del menú de pausa
function scrPausaTexto(_opcion){
	switch (_opcion){
		case PAUSA_CONTINUAR: return "CONTINUAR";
		case PAUSA_REINICIAR: return "REINICIAR NIVEL";
		case PAUSA_PANTALLA: return window_get_fullscreen() ? "VENTANA" : "PANTALLA COMPLETA";
		case PAUSA_MENU: return "SALIR AL MENÚ";
		case PAUSA_SALIR: return "SALIR DEL JUEGO";
	}
	return "";
}

/// Reinicia el nivel actual con el puntaje y las vidas con que empezó
/// (así reiniciar no sirve para acumular puntos)
function scrReiniciarNivel(){
	global.puntaje = global.puntaje_nivel;
	global.vidas = global.vidas_nivel;
	global.pausa = false;
	room_restart();
}

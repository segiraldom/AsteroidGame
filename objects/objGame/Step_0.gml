// F11: alternar pantalla completa / ventana
if keyboard_check_pressed(vk_f11){
	scrAlternarPantallaCompleta();
}

// Control del nivel
if temporizador > 0{
	temporizador -= 1;
}

switch (estado){
	case eEstadoNivel.INTRO:
		// Al empezar el nivel la nave es invulnerable mientras se ve el cartel
		if instance_exists(objPlayer){
			objPlayer.invulnerabilidad = max(objPlayer.invulnerabilidad, temporizador);
		}
		if temporizador <= 0{
			estado = eEstadoNivel.JUGANDO;
		}
		break;

	case eEstadoNivel.JUGANDO:
		// Nivel completado cuando no queda ninguna roca
		if instance_number(objRock) == 0{
			estado = eEstadoNivel.COMPLETADO;
			temporizador = NIVEL_PAUSA_FIN;
		}
		break;

	case eEstadoNivel.COMPLETADO:
		if temporizador <= 0{
			if global.nivel >= NIVELES_TOTAL{
				// Último nivel superado: pantalla final de victoria
				global.victoria = true;
				room_goto(rmGameOver);
			}else{
				// Siguiente nivel: se reinicia la sala conservando puntaje y vidas
				global.nivel += 1;
				room_restart();
			}
		}
		break;
}

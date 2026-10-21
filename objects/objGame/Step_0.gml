// F11: alternar pantalla completa / ventana
if keyboard_check_pressed(vk_f11){
	scrAlternarPantallaCompleta();
}

// Control del nivel
if temporizador > 0{
	temporizador -= 1;
}

// Sin vidas: se espera un momento para que se vea la explosión y luego game over
if global.vidas <= 0 && estado != eEstadoNivel.PERDIDO{
	estado = eEstadoNivel.PERDIDO;
	temporizador = PERDIDO_ESPERA;
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
		// Cada cierto tiempo aparece una ayuda flotando (una a la vez)
		ayuda_espera -= 1;
		if ayuda_espera <= 0{
			ayuda_espera = irandom_range(AYUDA_ESPERA_MIN, AYUDA_ESPERA_MAX);
			if !instance_exists(objPowerUp) && instance_exists(objPlayer){
				var _ax, _ay;
				do {
					_ax = random_range(AYUDA_MARGEN_SALA, room_width - AYUDA_MARGEN_SALA);
					_ay = random_range(AYUDA_MARGEN_SALA, room_height - AYUDA_MARGEN_SALA);
				} until (point_distance(_ax, _ay, objPlayer.x, objPlayer.y) > AYUDA_DISTANCIA_MIN_NAVE);
				var _ayuda = instance_create_layer(_ax, _ay, "Instances", objPowerUp);
				var _tipo = irandom(AYUDA_TIPOS_TEMPORALES - 1);
				// Vida extra: poco frecuente, una por nivel y nunca con el máximo de vidas
				if !vida_extra_lanzada && global.vidas < VIDAS_MAX && random(1) < AYUDA_PROB_VIDA{
					_tipo = AYUDA_VIDA;
					vida_extra_lanzada = true;
				}
				scrAplicarTipoAyuda(_ayuda, _tipo);
			}
		}

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

	case eEstadoNivel.PERDIDO:
		if temporizador <= 0{
			room_goto(rmGameOver);
		}
		break;
}

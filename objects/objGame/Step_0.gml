// F11: alternar pantalla completa / ventana
if keyboard_check_pressed(vk_f11){
	scrAlternarPantallaCompleta();
}

// En pausa se congela el nivel (cronómetro incluido)
if global.pausa{
	exit;
}

// Si terminó una pista de batalla, empieza otra
scrMusicaActualizar();

// Control del nivel
if temporizador > 0{
	temporizador -= 1;
}

// Sin vidas: las naves que queden también explotan y luego se va al game over
if global.vidas <= 0 && estado != eEstadoNivel.PERDIDO{
	estado = eEstadoNivel.PERDIDO;
	temporizador = PERDIDO_ESPERA;
	with (objPlayer){
		instance_create_layer(x, y, "Instances", objExplosion);
		instance_destroy();
	}
}

switch (estado){
	case eEstadoNivel.INTRO:
		// Al empezar el nivel las naves son invulnerables mientras se ve el cartel
		var _invuln = temporizador;
		with (objPlayer){
			invulnerabilidad = max(invulnerabilidad, _invuln);
		}
		if temporizador <= 0{
			estado = eEstadoNivel.JUGANDO;
		}
		break;

	case eEstadoNivel.JUGANDO:
		// El cronómetro solo corre mientras se juega (no en el cartel ni en la pausa final)
		tiempo_nivel += 1;

		// Cada cierto tiempo aparece una ayuda flotando (una a la vez)
		ayuda_espera -= 1;
		if ayuda_espera <= 0{
			ayuda_espera = irandom_range(AYUDA_ESPERA_MIN, AYUDA_ESPERA_MAX);
			// Vale cualquier nave que siga viva
			var _nave = instance_find(objPlayer, 0);
			if !instance_exists(objPowerUp) && _nave != noone{
				var _ax, _ay;
				do {
					_ax = random_range(AYUDA_MARGEN_SALA, room_width - AYUDA_MARGEN_SALA);
					_ay = random_range(AYUDA_MARGEN_SALA, room_height - AYUDA_MARGEN_SALA);
				} until (point_distance(_ax, _ay, _nave.x, _nave.y) > AYUDA_DISTANCIA_MIN_NAVE);
				var _ayuda = instance_create_layer(_ax, _ay, "Instances", objPowerUp);
				var _tipo = irandom(AYUDA_TIPOS_TEMPORALES - 1);
				// Vida extra: poco frecuente, una por nivel y nunca con el máximo de vidas
				if !vida_extra_lanzada && global.vidas < scrVidasMax() && random(1) < AYUDA_PROB_VIDA{
					_tipo = AYUDA_VIDA;
					vida_extra_lanzada = true;
				}
				scrAplicarTipoAyuda(_ayuda, _tipo);
			}
		}

		// Nivel completado cuando no queda ninguna roca ni ningún jefe
		if instance_number(objRock) == 0 && !scrExisteJefe(){
			estado = eEstadoNivel.COMPLETADO;
			temporizador = NIVEL_PAUSA_FIN;
			// Bono según el tiempo que tardó en completar el nivel
			bono_nivel = scrBonoTiempo(tiempo_nivel, global.nivel);
			global.puntaje += bono_nivel;
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

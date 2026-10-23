// En pausa no se mueve ni ataca
if global.pausa{
	exit;
}

if flash > 0{
	flash -= 1;
}

// Balanceo suave: el pulpo no gira como la roca, se mece
oscilacion += 1;
image_angle = sin(oscilacion * PULPO_BALANCEO_VEL) * PULPO_BALANCEO;

// Solo ataca mientras se juega (no durante los carteles)
var _activo = instance_exists(objGame) && objGame.estado == eEstadoNivel.JUGANDO;

// Fase según la vida que queda
var _fraccion = vida / vida_max;
if _fraccion > PULPO_FASE_2_VIDA{
	fase = 1;
}else if _fraccion > PULPO_FASE_3_VIDA{
	fase = 2;
}else{
	fase = 3;
}
var _velocidad = PULPO_VELOCIDAD * ((fase >= 2) ? PULPO_FASE_2_VEL : 1);

switch (accion){
	case eAccionJefe.DERIVA:
		speed = _velocidad;
		if _activo{
			// Lanza rocas hacia la nave más cercana: 1, 3 o 5 según la fase
			espera_ataque -= 1;
			if espera_ataque <= 0{
				var _cantidad = 1;
				if fase == 2{
					_cantidad = PULPO_ABANICO_ROCAS;
				}else if fase == 3{
					_cantidad = 5;
				}
				scrJefeEscupir(id, fase, _cantidad);

				// Y además dispara lasers desde los ojos: 1, 2 o 3 según la fase
				var _laseres = 1;
				if fase == 2{
					_laseres = PULPO_LASER_F2;
				}else if fase == 3{
					_laseres = PULPO_LASER_F3;
				}
				scrPulpoLanzarLasers(id, _laseres);
				if fase == 1{
					espera_ataque = PULPO_ESPERA_F1;
				}else if fase == 2{
					espera_ataque = PULPO_ESPERA_F2;
				}else{
					espera_ataque = PULPO_ESPERA_F3;
				}
			}
			// En la fase 3 también embiste
			if fase == 3{
				espera_embestida -= 1;
				if espera_embestida <= 0{
					accion = eAccionJefe.TEMBLOR;
					temporizador_accion = PULPO_TEMBLOR_DURACION;
				}
			}
		}
		break;

	case eAccionJefe.TEMBLOR:
		// Se detiene y tiembla antes de embestir
		speed = 0;
		temporizador_accion -= 1;
		if temporizador_accion <= 0{
			var _objetivo = instance_nearest(x, y, objPlayer);
			if _objetivo != noone{
				direction = point_direction(x, y, _objetivo.x, _objetivo.y);
			}
			accion = eAccionJefe.EMBESTIDA;
			temporizador_accion = PULPO_EMBESTIDA_DURACION;
		}
		break;

	case eAccionJefe.EMBESTIDA:
		speed = PULPO_EMBESTIDA_VEL;
		temporizador_accion -= 1;
		if temporizador_accion <= 0{
			accion = eAccionJefe.DERIVA;
			espera_embestida = PULPO_ESPERA_EMBESTIDA;
		}
		break;
}

// Rebota en los bordes laterales de la sala
if (bbox_left < 0 && hspeed < 0) || (bbox_right > room_width && hspeed > 0){
	hspeed = -hspeed;
}

// Se mantiene en la zona alta de la pantalla, amenazando desde arriba
if bbox_top < PULPO_ZONA_TOPE{
	vspeed = abs(vspeed);
}else if bbox_bottom > room_height * PULPO_ZONA_FRACCION{
	vspeed = -abs(vspeed);
}

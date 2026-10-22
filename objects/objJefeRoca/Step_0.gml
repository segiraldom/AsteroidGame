if flash > 0{
	flash -= 1;
}
image_angle += JEFE_GIRO;

// Solo ataca mientras se juega (no durante los carteles)
var _activo = instance_exists(objGame) && objGame.estado == eEstadoNivel.JUGANDO;

// Fase según la vida que queda
var _fraccion = vida / vida_max;
if _fraccion > JEFE_FASE_2_VIDA{
	fase = 1;
}else if _fraccion > JEFE_FASE_3_VIDA{
	fase = 2;
}else{
	fase = 3;
}
var _velocidad = JEFE_VELOCIDAD * ((fase >= 2) ? JEFE_FASE_2_VEL : 1);

switch (accion){
	case eAccionJefe.DERIVA:
		speed = _velocidad;
		if _activo{
			// Lanza rocas hacia la nave más cercana
			espera_ataque -= 1;
			if espera_ataque <= 0{
				scrJefeEscupir(id, fase);
				if fase == 1{
					espera_ataque = JEFE_ESPERA_F1;
				}else if fase == 2{
					espera_ataque = JEFE_ESPERA_F2;
				}else{
					espera_ataque = JEFE_ESPERA_F3;
				}
			}
			// En la fase 3 también embiste
			if fase == 3{
				espera_embestida -= 1;
				if espera_embestida <= 0{
					accion = eAccionJefe.TEMBLOR;
					temporizador_accion = JEFE_TEMBLOR_DURACION;
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
			temporizador_accion = JEFE_EMBESTIDA_DURACION;
		}
		break;

	case eAccionJefe.EMBESTIDA:
		speed = JEFE_EMBESTIDA_VEL;
		temporizador_accion -= 1;
		if temporizador_accion <= 0{
			accion = eAccionJefe.DERIVA;
			espera_embestida = JEFE_ESPERA_EMBESTIDA;
		}
		break;
}

// Rebota en los bordes de la sala
if (bbox_left < 0 && hspeed < 0) || (bbox_right > room_width && hspeed > 0){
	hspeed = -hspeed;
}
if (bbox_top < 0 && vspeed < 0) || (bbox_bottom > room_height && vspeed > 0){
	vspeed = -vspeed;
}

// F11: pantalla completa
if keyboard_check_pressed(vk_f11){
	scrAlternarPantallaCompleta();
}

tiempo += 1;

switch (fase){
	case eFaseFinal.NOMBRE:
		// Lo que se tecleó durante la partida (WASD, espacio...) no cuenta como nombre
		if tiempo <= GAMEOVER_GRACIA{
			keyboard_string = "";
		}

		// Solo caracteres válidos y largo máximo
		keyboard_string = scrNombreLimpio(keyboard_string);

		// La inactividad se reinicia al tocar cualquier tecla
		if keyboard_check(vk_anykey){
			inactividad = 0;
		}else{
			inactividad += 1;
		}

		// Confirmar con Enter (pasado un instante) o al agotarse la inactividad
		var _confirmar = (tiempo > GAMEOVER_GRACIA && keyboard_check_pressed(vk_enter))
			|| inactividad >= NOMBRE_INACTIVIDAD;

		if _confirmar{
			if keyboard_check_pressed(vk_enter){
				scrClic();
			}
			var _nombre = keyboard_string;
			// Vacío o solo espacios: nombre genérico
			if string_length(string_replace_all(_nombre, " ", "")) == 0{
				_nombre = scrNombreGenerico(modo, true);
			}
			resaltado = scrTopsAgregar(modo, _nombre, global.puntaje, global.nivel);
			fase = eFaseFinal.LISTA;
			tiempo_lista = 0;
		}
		break;

	case eFaseFinal.LISTA:
		tiempo_lista += 1;

		// Se puede saltar con Enter, Espacio o clic (pasado un instante, para no saltarla por error)
		var _saltar = tiempo_lista > GAMEOVER_GRACIA
			&& (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left));

		// Volver al menú al saltar o al terminar la espera
		if _saltar || tiempo_lista >= TOP_ESPERA_LISTA{
			if _saltar{
				scrClic();
			}
			room_goto(rmMenu);
		}
		break;
}

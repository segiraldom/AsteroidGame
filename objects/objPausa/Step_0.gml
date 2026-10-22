// --- Partida en marcha: Esc abre la pausa ---
if !global.pausa{
	// Solo se puede pausar mientras se juega (no en los carteles finales ni al perder)
	if keyboard_check_pressed(vk_escape) && instance_exists(objGame) && global.vidas > 0
		&& (objGame.estado == eEstadoNivel.INTRO || objGame.estado == eEstadoNivel.JUGANDO){
		scrPausar();
		seleccion = PAUSA_CONTINUAR;
		confirmar = -1;
		mouse_previo_x = mouse_x;
		mouse_previo_y = mouse_y;
	}
	exit;
}

// --- En pausa ---
var _en_confirmacion = (confirmar >= 0);
var _total = _en_confirmacion ? 2 : PAUSA_TOTAL;
var _lista = _en_confirmacion ? botones_conf : botones;

// Esc: cancela la confirmación o reanuda
if keyboard_check_pressed(vk_escape){
	if _en_confirmacion{
		seleccion = confirmar;
		confirmar = -1;
	}else{
		scrReanudar();
	}
	exit;
}

// Teclado: flechas o W/S (en la confirmación también izquierda / derecha)
if keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || (_en_confirmacion && keyboard_check_pressed(vk_right)){
	seleccion = (seleccion + 1) mod _total;
}
if keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || (_en_confirmacion && keyboard_check_pressed(vk_left)){
	seleccion = (seleccion - 1 + _total) mod _total;
}

// Ratón: qué botón está bajo el cursor (-1 si ninguno)
var _hover = -1;
for (var i = 0; i < _total; i++){
	var _b = _lista[i];
	if point_in_rectangle(mouse_x, mouse_y, _b.x1, _b.y1, _b.x2, _b.y2){
		_hover = i;
	}
}
if (mouse_x != mouse_previo_x || mouse_y != mouse_previo_y) && _hover >= 0{
	seleccion = _hover;
}
mouse_previo_x = mouse_x;
mouse_previo_y = mouse_y;

// Activar: Enter, Espacio o clic sobre un botón
var _clic = mouse_check_button_pressed(mb_left) && _hover >= 0;
if keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || _clic{
	if _clic{
		seleccion = _hover;
	}
	if _en_confirmacion{
		if seleccion == 0{
			// SÍ: se ejecuta la salida
			if confirmar == PAUSA_MENU{
				global.pausa = false;
				room_goto(rmMenu);
			}else{
				game_end();
			}
		}else{
			// NO: vuelve a la lista
			seleccion = confirmar;
			confirmar = -1;
		}
	}else{
		switch (seleccion){
			case PAUSA_CONTINUAR:
				scrReanudar();
				break;
			case PAUSA_REINICIAR:
				scrReiniciarNivel();
				break;
			case PAUSA_PANTALLA:
				scrAlternarPantallaCompleta();
				break;
			case PAUSA_MENU:
			case PAUSA_SALIR:
				// Pide confirmación; empieza seleccionado NO para evitar accidentes
				confirmar = seleccion;
				seleccion = 1;
				break;
		}
	}
}

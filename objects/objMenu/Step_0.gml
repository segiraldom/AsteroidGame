// F11: pantalla completa
if keyboard_check_pressed(vk_f11){
	scrAlternarPantallaCompleta();
}

var _total = array_length(opciones);

// Teclado: flechas o W/S
if keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")){
	seleccion = (seleccion + 1) mod _total;
}
if keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")){
	seleccion = (seleccion - 1 + _total) mod _total;
}

// El modo de juego se cambia con izquierda / derecha mientras está seleccionado
if seleccion == MENU_MODO && (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)){
	scrAlternarModo();
}

// Ratón: qué botón está bajo el cursor (-1 si ninguno)
var _hover = -1;
for (var i = 0; i < _total; i++){
	var _b = botones[i];
	if point_in_rectangle(mouse_x, mouse_y, _b.x1, _b.y1, _b.x2, _b.y2){
		_hover = i;
	}
}

// Solo cambia la selección si el ratón se movió
if (mouse_x != mouse_previo_x || mouse_y != mouse_previo_y) && _hover >= 0{
	seleccion = _hover;
}
mouse_previo_x = mouse_x;
mouse_previo_y = mouse_y;

// Activar: Enter, Espacio o clic sobre un botón
var _activar = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)
	|| (mouse_check_button_pressed(mb_left) && _hover >= 0);

if _activar{
	if _hover >= 0 && mouse_check_button_pressed(mb_left){
		seleccion = _hover;
	}
	switch (seleccion){
		case MENU_MODO:
			scrAlternarModo();
			break;
		case MENU_JUGAR:
			scrIniciarPartida();
			room_goto(Room1);
			break;
		case MENU_SALIR: game_end(); break;
	}
}

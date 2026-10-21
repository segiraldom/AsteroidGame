// F11: pantalla completa
if keyboard_check_pressed(vk_f11){
	scrAlternarPantallaCompleta();
}

tiempo += 1;

// Se puede saltar con Enter, Espacio o clic (pasado un instante, para no saltarla por error)
var _saltar = tiempo > GAMEOVER_GRACIA
	&& (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left));

// Volver al menú al saltar o al terminar la espera
if _saltar || tiempo >= GAMEOVER_ESPERA{
	room_goto(rmMenu);
}

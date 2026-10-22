// F11: pantalla completa
if keyboard_check_pressed(vk_f11){
	scrAlternarPantallaCompleta();
}

tiempo += 1;

if confirmando{
	// Enter confirma el borrado, Esc lo cancela
	if keyboard_check_pressed(vk_enter){
		scrTopsBorrar();
		confirmando = false;
	}else if keyboard_check_pressed(vk_escape){
		confirmando = false;
	}
}else{
	// Tecla escondida: Ctrl + Mayús + Supr pide confirmar el borrado de todos los puntajes
	if keyboard_check(vk_control) && keyboard_check(vk_shift) && keyboard_check_pressed(vk_delete){
		confirmando = true;
	}else if tiempo > GAMEOVER_GRACIA
		&& (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)){
		// Volver al menú con Esc, Enter, Espacio o clic
		room_goto(rmMenu);
	}
}

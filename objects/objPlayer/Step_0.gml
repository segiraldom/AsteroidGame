//Movimiento (flechas o WASD)
if keyboard_check(vk_up) || keyboard_check(ord("W")){
	motion_add(image_angle, JUGADOR_ACELERACION);
}

if keyboard_check(vk_left) || keyboard_check(ord("A")){
	image_angle += JUGADOR_GIRO;
}

if keyboard_check(vk_right) || keyboard_check(ord("D")){
	image_angle -= JUGADOR_GIRO;
}

//Limitar la velocidad máxima
if speed > JUGADOR_VEL_MAX{
	speed = JUGADOR_VEL_MAX;
}

//Disparo (clic izquierdo o espacio; se puede mantener pulsado)
if espera_disparo > 0{
	espera_disparo -= 1;
}

if (mouse_check_button(mb_left) || keyboard_check(vk_space)) && espera_disparo <= 0{
	// La bala nace en la punta de la nave
	var _x = x + lengthdir_x(BALA_DISTANCIA_PUNTA, image_angle);
	var _y = y + lengthdir_y(BALA_DISTANCIA_PUNTA, image_angle);
	var _bala = instance_create_layer(_x, _y, "Instances", objBullet);
	_bala.direction = image_angle;
	_bala.image_angle = image_angle;
	espera_disparo = JUGADOR_CADENCIA;
}

//salida del escenario
move_wrap(true,true,0);

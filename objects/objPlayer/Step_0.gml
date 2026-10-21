//Movimiento
if keyboard_check(vk_up){
	motion_add(image_angle, 0.1);
}

if keyboard_check(vk_left){
	image_angle+=1;
}

if keyboard_check(vk_right){
	image_angle-=1;
}

//Disparo
if mouse_check_button_pressed(mb_left){
	instance_create_layer(x,y,"Instances", objBullet);
}

//salida del escenario
move_wrap(true,true,0);


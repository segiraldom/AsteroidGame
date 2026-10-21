instance_destroy(other);
if sprite_index == sprRockBig{
	global.puntaje += PUNTOS_ROCA_GRANDE;
	sprite_index = sprRockSmall;
	instance_copy(true);
}else{
	global.puntaje += PUNTOS_ROCA_PEQUENA;
	instance_destroy();
}

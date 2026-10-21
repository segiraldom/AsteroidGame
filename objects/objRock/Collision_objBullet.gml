instance_destroy(other);

// La roca resistente aguanta varios impactos
vida -= 1;
if vida > 0{
	exit;
}

if sprite_index == sprRockBig{
	global.puntaje += PUNTOS_ROCA_GRANDE;
	sprite_index = sprRockSmall;
	vida = 1;
	var _copia = instance_copy(true);
	// La copia vuelve a ejecutar Create: se le pasan las propiedades de esta roca
	_copia.tipo = tipo;
	_copia.vida = 1;
	_copia.image_blend = image_blend;
	_copia.speed = speed;
}else{
	global.puntaje += PUNTOS_ROCA_PEQUENA;
	instance_destroy();
}

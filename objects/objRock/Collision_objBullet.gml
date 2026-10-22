// Se lee antes de destruir la bala
var _bala_fuerte = other.dano_extra;

instance_destroy(other);

// Bala de "más daño": destruye la roca entera, sin partirla
if _bala_fuerte{
	if sprite_index == sprRockBig{
		global.puntaje += PUNTOS_ROCA_GRANDE;
	}else{
		global.puntaje += PUNTOS_ROCA_PEQUENA;
	}
	scrSonido(sndExplosion, VOL_EXPLOSION);
	instance_destroy();
	exit;
}

// La roca resistente aguanta varios impactos
vida -= 1;
if vida > 0{
	// Aguantó el impacto
	scrSonido(sndChoque, VOL_CHOQUE);
	exit;
}

// La roca se parte o se destruye
scrSonido(sndExplosion, VOL_EXPLOSION);

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

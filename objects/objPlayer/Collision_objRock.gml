// Mientras es invulnerable, las rocas no le hacen daño
if invulnerabilidad > 0{
	exit;
}

// Si ya no quedan vidas, la nave ya explotó (evita contar dos choques en el mismo frame)
if global.vidas <= 0{
	exit;
}

global.vidas -= 1;

// Explosión en el lugar de la nave
instance_create_layer(x, y, "Instances", objExplosion);

if global.vidas <= 0{
	// Sin vidas: la nave desaparece y objGame lleva al game over cuando termina la explosión
	instance_destroy();
}else{
	// Sigue en el mismo sitio, con invulnerabilidad temporal
	invulnerabilidad = JUGADOR_INVULNERABILIDAD;
}

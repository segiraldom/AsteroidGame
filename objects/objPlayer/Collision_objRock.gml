// Mientras es invulnerable, las rocas no le hacen daño
if invulnerabilidad > 0{
	exit;
}

// Si ya no quedan vidas, la nave ya explotó (evita contar dos choques en el mismo frame)
if global.vidas <= 0{
	exit;
}

// El escudo absorbe el golpe y destruye la roca
if ayuda_escudo > 0{
	ayuda_escudo = 0;
	invulnerabilidad = ESCUDO_ROMPE_INVULN;
	scrSonido(sndChoque, VOL_CHOQUE);
	with (other){
		instance_destroy();
	}
	exit;
}

global.vidas -= 1;

// Al perder una vida se pierden las ayudas
ayuda_multi = 0;
ayuda_dano = 0;

// Explosión en el lugar de la nave
instance_create_layer(x, y, "Instances", objExplosion);

if global.vidas <= 0{
	// Sin vidas: la nave desaparece y objGame lleva al game over cuando termina la explosión
	instance_destroy();
}else{
	// Sigue en el mismo sitio, con invulnerabilidad temporal
	invulnerabilidad = JUGADOR_INVULNERABILIDAD;
}

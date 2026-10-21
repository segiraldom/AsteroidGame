// Mientras es invulnerable, las rocas no le hacen daño
if invulnerabilidad > 0{
	exit;
}

global.vidas -= 1;

if global.vidas <= 0{
	// Sin vidas: pantalla de game over
	room_goto(rmGameOver);
}else{
	// Sigue en el mismo sitio, con invulnerabilidad temporal
	invulnerabilidad = JUGADOR_INVULNERABILIDAD;
}

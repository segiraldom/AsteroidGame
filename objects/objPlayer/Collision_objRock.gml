// Mientras es invulnerable, las rocas no le hacen daño
if invulnerabilidad > 0{
	exit;
}

global.vidas -= 1;

if global.vidas <= 0{
	// Sin vidas: pantalla de game over
	room_goto(rmGameOver);
}else{
	// Reaparecer en el centro, quieta y con invulnerabilidad temporal
	x = room_width / 2;
	y = room_height / 2;
	speed = 0;
	image_angle = 90;
	invulnerabilidad = JUGADOR_INVULNERABILIDAD;
}

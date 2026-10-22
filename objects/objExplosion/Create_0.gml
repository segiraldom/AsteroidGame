// Se dibuja por encima de la nave y las rocas
depth = -50;

tiempo = 0;

// Sonido de la explosión
scrSonidoExplosion();

// Fragmentos de la nave que salen despedidos en todas direcciones
var _px = x;
var _py = y;
particulas = [];
repeat (EXPLOSION_PARTICULAS){
	var _dir = random(360);
	var _vel = random_range(EXPLOSION_VEL_MIN, EXPLOSION_VEL_MAX);
	array_push(particulas, {
		px: _px,
		py: _py,
		vx: lengthdir_x(_vel, _dir),
		vy: lengthdir_y(_vel, _dir),
		largo: random_range(EXPLOSION_LARGO_MIN, EXPLOSION_LARGO_MAX),
		ang: random(360),
		giro: random_range(-EXPLOSION_GIRO_MAX, EXPLOSION_GIRO_MAX)
	});
}

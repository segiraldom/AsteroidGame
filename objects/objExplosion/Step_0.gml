tiempo += 1;

// Mover y girar cada fragmento, frenando poco a poco
for (var i = 0; i < array_length(particulas); i++){
	var _p = particulas[i];
	_p.px += _p.vx;
	_p.py += _p.vy;
	_p.vx *= EXPLOSION_FRICCION;
	_p.vy *= EXPLOSION_FRICCION;
	_p.ang += _p.giro;
}

if tiempo >= EXPLOSION_DURACION{
	instance_destroy();
}

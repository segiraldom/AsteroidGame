// Todo se desvanece con el tiempo
draw_set_alpha(1 - tiempo / EXPLOSION_DURACION);
draw_set_color(c_white);

// Fragmentos: pequeñas líneas que giran
for (var i = 0; i < array_length(particulas); i++){
	var _p = particulas[i];
	var _dx = lengthdir_x(_p.largo / 2, _p.ang);
	var _dy = lengthdir_y(_p.largo / 2, _p.ang);
	draw_line(_p.px - _dx, _p.py - _dy, _p.px + _dx, _p.py + _dy);
}

// Onda expansiva
draw_circle(x, y, tiempo * EXPLOSION_ONDA_VEL, true);

// Restaurar valores por defecto
draw_set_alpha(1);
draw_set_color(c_white);

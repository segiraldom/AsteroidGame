// En pausa el laser se congela (como las rocas)
if global.pausa{
	exit;
}

// A mano (y no con speed) para que la pausa lo detenga de verdad
x += lengthdir_x(PULPO_LASER_VELOCIDAD, direction);
y += lengthdir_y(PULPO_LASER_VELOCIDAD, direction);

vida -= 1;
if vida <= 0{
	instance_destroy();
}

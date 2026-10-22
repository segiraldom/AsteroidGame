// En pausa no avanza ni caduca
if global.pausa{
	exit;
}

latido += 1;

// Desaparece si nadie la recoge
vida -= 1;
if vida <= 0{
	instance_destroy();
}

move_wrap(true, true, 0);

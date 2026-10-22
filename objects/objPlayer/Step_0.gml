// En pausa no se mueve ni dispara
if global.pausa{
	exit;
}

//Invulnerabilidad temporal tras perder una vida (la nave parpadea)
if invulnerabilidad > 0{
	invulnerabilidad -= 1;
	image_alpha = (invulnerabilidad mod JUGADOR_PARPADEO < JUGADOR_PARPADEO / 2) ? 0.3 : 1;
}else{
	image_alpha = 1;
}

//Duración de las ayudas
if ayuda_escudo > 0{
	ayuda_escudo -= 1;
}
if ayuda_multi > 0{
	ayuda_multi -= 1;
}
if ayuda_dano > 0{
	ayuda_dano -= 1;
}

//Movimiento (las teclas de este jugador; ver scrControles)
if scrAlgunaTecla(controles.arriba){
	motion_add(image_angle, JUGADOR_ACELERACION);
}

if scrAlgunaTecla(controles.abajo){
	motion_add(image_angle + 180, JUGADOR_ACELERACION_ATRAS);
}

if scrAlgunaTecla(controles.izquierda){
	image_angle += JUGADOR_GIRO;
}

if scrAlgunaTecla(controles.derecha){
	image_angle -= JUGADOR_GIRO;
}

//Limitar la velocidad máxima
if speed > JUGADOR_VEL_MAX{
	speed = JUGADOR_VEL_MAX;
}

//Disparo (clic izquierdo o espacio; se puede mantener pulsado)
if espera_disparo > 0{
	espera_disparo -= 1;
}

//Disparo (la tecla de este jugador; el jugador 1 también dispara con el clic)
var _disparando = scrAlgunaTecla(controles.disparo);
if numero == 1{
	_disparando = _disparando || mouse_check_button(mb_left);
}

if _disparando && espera_disparo <= 0{
	// La bala nace en la punta de la nave
	var _x = x + lengthdir_x(BALA_DISTANCIA_PUNTA, image_angle);
	var _y = y + lengthdir_y(BALA_DISTANCIA_PUNTA, image_angle);
	// Disparo múltiple: 3 balas en abanico; si no, una sola al frente
	var _desvios = (ayuda_multi > 0) ? [-MULTI_ANGULO, 0, MULTI_ANGULO] : [0];
	for (var i = 0; i < array_length(_desvios); i++){
		var _bala = instance_create_layer(_x, _y, "Instances", objBullet);
		_bala.direction = image_angle + _desvios[i];
		_bala.image_angle = _bala.direction;
		if ayuda_dano > 0{
			// Más daño: bala roja y más grande
			_bala.dano_extra = true;
			_bala.sprite_index = sprBulletDano;
			_bala.image_blend = COLOR_AYUDA_DANO;
		}else if ayuda_multi > 0{
			_bala.image_blend = COLOR_AYUDA_MULTI;
		}
	}
	espera_disparo = JUGADOR_CADENCIA;
}

//salida del escenario
move_wrap(true,true,0);

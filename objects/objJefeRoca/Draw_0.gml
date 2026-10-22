// Color según la fase; blanco un instante al recibir un disparo
var _color = make_color_rgb(150, 40, 40);
if fase == 2{
	_color = make_color_rgb(200, 40, 30);
}else if fase == 3{
	_color = make_color_rgb(255, 50, 50);
}
if flash > 0{
	_color = c_white;
}

// Antes de embestir tiembla
var _tx = 0;
var _ty = 0;
if accion == eAccionJefe.TEMBLOR{
	_tx = random_range(-JEFE_TEMBLOR_FUERZA, JEFE_TEMBLOR_FUERZA);
	_ty = random_range(-JEFE_TEMBLOR_FUERZA, JEFE_TEMBLOR_FUERZA);
}
draw_sprite_ext(sprite_index, 0, x + _tx, y + _ty, image_xscale, image_yscale, image_angle, _color, 1);

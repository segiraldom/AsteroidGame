// Color según la fase; blanco un instante al recibir un disparo
var _color = scrPulpoColor(fase);
if flash > 0{
	_color = c_white;
}

// Antes de embestir tiembla
var _tx = 0;
var _ty = 0;
if accion == eAccionJefe.TEMBLOR{
	_tx = random_range(-PULPO_TEMBLOR_FUERZA, PULPO_TEMBLOR_FUERZA);
	_ty = random_range(-PULPO_TEMBLOR_FUERZA, PULPO_TEMBLOR_FUERZA);
}
draw_sprite_ext(sprite_index, 0, x + _tx, y + _ty, image_xscale, image_yscale, image_angle, _color, 1);

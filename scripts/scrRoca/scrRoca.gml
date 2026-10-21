























/// Aplica un tipo de roca (normal, rápida o resistente) a una roca ya creada
function scrAplicarTipoRoca(_roca, _tipo){
	_roca.tipo = _tipo;
	switch (_tipo){
		case ROCA_RAPIDA:
			_roca.speed *= ROCA_RAPIDA_FACTOR;
			_roca.image_blend = c_orange;
			break;
		case ROCA_RESISTENTE:
			_roca.vida = ROCA_RESISTENTE_VIDA;
			_roca.image_blend = c_aqua;
			break;
	}
}

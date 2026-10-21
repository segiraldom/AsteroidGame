/// Funciones de las ayudas (power-ups)

/// Sprite de un tipo de ayuda
function scrAyudaSprite(_tipo){
	switch (_tipo){
		case AYUDA_ESCUDO: return sprPowerEscudo;
		case AYUDA_MULTI: return sprPowerMulti;
		case AYUDA_DANO: return sprPowerDano;
		case AYUDA_VIDA: return sprPowerVida;
	}
	return sprPowerEscudo;
}

/// Color de un tipo de ayuda (los sprites son blancos y se tiñen)
function scrAyudaColor(_tipo){
	switch (_tipo){
		case AYUDA_ESCUDO: return COLOR_AYUDA_ESCUDO;
		case AYUDA_MULTI: return COLOR_AYUDA_MULTI;
		case AYUDA_DANO: return COLOR_AYUDA_DANO;
		case AYUDA_VIDA: return COLOR_AYUDA_VIDA;
	}
	return c_white;
}

/// Nombre de un tipo de ayuda, para el HUD
function scrAyudaNombre(_tipo){
	switch (_tipo){
		case AYUDA_ESCUDO: return "ESCUDO";
		case AYUDA_MULTI: return "DISPARO MÚLTIPLE";
		case AYUDA_DANO: return "MÁS DAÑO";
		case AYUDA_VIDA: return "VIDA EXTRA";
	}
	return "";
}

/// Frames que le quedan a una ayuda en el jugador (0 si no está activa; la vida extra no tiene duración)
function scrAyudaTiempo(_jugador, _tipo){
	switch (_tipo){
		case AYUDA_ESCUDO: return _jugador.ayuda_escudo;
		case AYUDA_MULTI: return _jugador.ayuda_multi;
		case AYUDA_DANO: return _jugador.ayuda_dano;
	}
	return 0;
}

/// Convierte una ayuda recién creada en un tipo concreto (sprite y color)
function scrAplicarTipoAyuda(_ayuda, _tipo){
	_ayuda.tipo = _tipo;
	_ayuda.sprite_index = scrAyudaSprite(_tipo);
	_ayuda.image_blend = scrAyudaColor(_tipo);
}

/// Activa una ayuda en el jugador
function scrDarAyuda(_jugador, _tipo){
	switch (_tipo){
		case AYUDA_ESCUDO: _jugador.ayuda_escudo = AYUDA_DURACION; break;
		case AYUDA_MULTI: _jugador.ayuda_multi = AYUDA_DURACION; break;
		case AYUDA_DANO: _jugador.ayuda_dano = AYUDA_DURACION; break;
		case AYUDA_VIDA: global.vidas = min(VIDAS_MAX, global.vidas + 1); break;
	}
}

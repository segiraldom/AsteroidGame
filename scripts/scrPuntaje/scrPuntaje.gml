/// Funciones del puntaje por tiempo

/// Puntos extra según lo que tardó el jugador en completar un nivel.
/// Los límites de tiempo crecen un poco con el nivel (los niveles altos son más largos).
function scrBonoTiempo(_frames, _nivel){
	var _factor = 1 + BONO_CRECIMIENTO_NIVEL * (_nivel - 1);
	var _segundos = _frames / FPS_JUEGO;

	if _segundos < BONO_TIEMPO_1 * _factor{
		return BONO_PUNTOS_1;
	}
	if _segundos < BONO_TIEMPO_2 * _factor{
		return BONO_PUNTOS_2;
	}
	if _segundos < BONO_TIEMPO_3 * _factor{
		return BONO_PUNTOS_3;
	}
	return 0;
}

/// Convierte frames a texto "m:ss"
function scrFormatoTiempo(_frames){
	var _total = floor(_frames / FPS_JUEGO);
	var _seg = _total mod 60;
	return string(_total div 60) + ":" + (_seg < 10 ? "0" : "") + string(_seg);
}

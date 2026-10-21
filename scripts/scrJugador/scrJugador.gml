/// Controles y configuración de las naves de los jugadores

/// true si alguna de las teclas de la lista está pulsada
function scrAlgunaTecla(_teclas){
	for (var i = 0; i < array_length(_teclas); i++){
		if keyboard_check(_teclas[i]){
			return true;
		}
	}
	return false;
}

/// Teclas de un jugador (1 o 2)
/// _multi: true en modo 2 jugadores, donde cada uno manda con su propio teclado
function scrControles(_numero, _multi){
	if _numero == 1 && !_multi{
		// Un jugador: valen tanto WASD como las flechas
		return {
			arriba: [ord("W"), vk_up],
			abajo: [ord("S"), vk_down],
			izquierda: [ord("A"), vk_left],
			derecha: [ord("D"), vk_right],
			disparo: [vk_space]
		};
	}
	if _numero == 1{
		// Dos jugadores: el jugador 1 usa W A S D y dispara con Espacio
		return {
			arriba: [ord("W")],
			abajo: [ord("S")],
			izquierda: [ord("A")],
			derecha: [ord("D")],
			disparo: [vk_space]
		};
	}
	// Dos jugadores: el jugador 2 usa las flechas y dispara con Enter
	return {
		arriba: [vk_up],
		abajo: [vk_down],
		izquierda: [vk_left],
		derecha: [vk_right],
		disparo: [vk_enter]
	};
}

/// Deja una nave recién creada lista para un jugador concreto
function scrConfigurarJugador(_nave, _numero){
	_nave.numero = _numero;
	_nave.controles = scrControles(_numero, scrMultijugador());
	_nave.image_blend = (_numero == 2) ? COLOR_JUGADOR_2 : COLOR_JUGADOR_1;
}

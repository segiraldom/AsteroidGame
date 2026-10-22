/// Reinicia las variables globales para empezar una partida nueva
function scrIniciarPartida(){
	global.puntaje = 0;
	global.vidas = scrVidasIniciales();
	global.nivel = 1;
	global.victoria = false;
}

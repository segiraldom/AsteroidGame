// Dibujar el HUD por encima de todo
depth = -100;

// Si se abre Room1 directamente (sin pasar por el menú), crear las variables globales
if !variable_global_exists("puntaje"){
	scrIniciarPartida();
}

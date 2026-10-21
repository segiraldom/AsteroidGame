// Jugador al que pertenece esta nave (1 o 2), con sus teclas y su color.
// objGame cambia el de la segunda nave al crearla en modo 2 jugadores.
scrConfigurarJugador(self, 1);

// Fricción para que la nave frene sola (ver scrConfig)
friction = JUGADOR_FRICCION;

// Frames que faltan para poder disparar otra vez
espera_disparo = 0;

// Frames que quedan de invulnerabilidad (0 = vulnerable)
invulnerabilidad = 0;

// Frames que quedan de cada ayuda (0 = inactiva)
ayuda_escudo = 0;
ayuda_multi = 0;
ayuda_dano = 0;

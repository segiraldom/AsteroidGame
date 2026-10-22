// Roca gigante: el jefe del nivel 5
image_xscale = JEFE_ESCALA;
image_yscale = JEFE_ESCALA;

vida_max = scrJefeVidaMax();
vida = vida_max;
fase = 1;
accion = eAccionJefe.DERIVA;
temporizador_accion = 0;
espera_ataque = JEFE_ESPERA_F1;
espera_embestida = JEFE_ESPERA_EMBESTIDA;
flash = 0;

// Empieza a la deriva hacia un lado (no hacia las naves, que empiezan abajo)
direction = choose(0, 180) + random_range(-30, 30);
speed = JEFE_VELOCIDAD;

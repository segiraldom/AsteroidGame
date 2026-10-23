// Pulpo alienígena: el jefe final del nivel 10
image_xscale = PULPO_ESCALA;
image_yscale = PULPO_ESCALA;

vida_max = scrJefeVidaMax();
vida = vida_max;
fase = 1;
accion = eAccionJefe.DERIVA;
temporizador_accion = 0;
espera_ataque = PULPO_ESPERA_F1;
espera_embestida = PULPO_ESPERA_EMBESTIDA;
flash = 0;
oscilacion = 0;

// Rocas que lanza: abanico, velocidad y máximo en pantalla (los lee scrJefeEscupir)
abanico = PULPO_ABANICO;
vel_lanzada = PULPO_VEL_LANZADA;
max_lanzadas = PULPO_MAX_LANZADAS;

// Empieza a la deriva hacia un lado (no hacia las naves, que empiezan abajo)
direction = choose(0, 180) + random_range(-20, 20);
speed = PULPO_VELOCIDAD;

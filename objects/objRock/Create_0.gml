// Las rocas del menú se crean antes de que existan las variables de partida
var _nivel = variable_global_exists("nivel") ? global.nivel : 1;

tipo = ROCA_NORMAL;
vida = 1;
speed = ROCA_VELOCIDAD + (_nivel - 1) * ROCA_VELOCIDAD_POR_NIVEL;
direction = random(360);
image_angle = random(360);

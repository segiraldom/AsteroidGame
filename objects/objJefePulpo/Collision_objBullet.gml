// Se lee antes de destruir la bala
var _dano = other.dano_extra ? JEFE_DANO_FUERTE : 1;
instance_destroy(other);

vida -= _dano;
flash = PULPO_FLASH;
scrSonido(sndChoque, VOL_CHOQUE);
global.puntaje += JEFE_PUNTOS_IMPACTO;

if vida <= 0{
	scrJefeDerrotado(id, PULPO_PUNTOS_DERROTA, PULPO_EXPLOSIONES);
}

draw_self();

// Escudo: aro azul alrededor de la nave (parpadea cuando está por acabarse)
if ayuda_escudo > 0{
	if ayuda_escudo > AYUDA_PARPADEO_INICIO || (ayuda_escudo div 6) mod 2 == 0{
		draw_sprite_ext(sprEscudo, 0, x, y, 1, 1, 0, COLOR_AYUDA_ESCUDO, 1);
	}
}

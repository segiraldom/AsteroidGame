// Parpadea en los últimos segundos para avisar que va a desaparecer
if vida < AYUDA_PARPADEO_INICIO && (vida div 6) mod 2 == 0{
	exit;
}

// Aro que late alrededor del icono
draw_set_color(image_blend);
draw_set_alpha(0.5);
draw_circle(x, y, AYUDA_RADIO + 4 * sin(latido * 0.1), true);
draw_set_alpha(1);
draw_set_color(c_white);

draw_self();

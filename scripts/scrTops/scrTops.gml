/// Mejores puntajes: dos top 10 (1 jugador y 2 jugadores) guardados en un archivo.
/// global.tops[0] = top de 1 jugador, global.tops[1] = top de 2 jugadores.
/// Cada entrada es un struct: { nombre, puntaje, nivel }.

/// Lee el archivo de puntajes y deja los tops en memoria
function scrTopsCargar(){
	global.tops = [[], []];
	global.anonimos = [0, 0];

	ini_open(TOP_ARCHIVO);
	for (var m = 0; m < 2; m++){
		var _sec = "modo" + string(m + 1);
		var _cantidad = min(TOP_MAX, ini_read_real(_sec, "cantidad", 0));
		for (var i = 0; i < _cantidad; i++){
			array_push(global.tops[m], {
				nombre: ini_read_string(_sec, "nombre" + string(i), ""),
				puntaje: ini_read_real(_sec, "puntaje" + string(i), 0),
				nivel: ini_read_real(_sec, "nivel" + string(i), 1)
			});
		}
		global.anonimos[m] = ini_read_real(_sec, "anonimos", 0);
	}
	ini_close();
}

/// Carga los tops solo si todavía no están en memoria
function scrTopsAsegurar(){
	if !variable_global_exists("tops"){
		scrTopsCargar();
	}
}

/// Escribe los tops y los contadores de nombres genéricos en el archivo
function scrTopsGuardar(){
	ini_open(TOP_ARCHIVO);
	for (var m = 0; m < 2; m++){
		var _sec = "modo" + string(m + 1);
		var _lista = global.tops[m];
		ini_write_real(_sec, "cantidad", array_length(_lista));
		for (var i = 0; i < array_length(_lista); i++){
			ini_write_string(_sec, "nombre" + string(i), _lista[i].nombre);
			ini_write_real(_sec, "puntaje" + string(i), _lista[i].puntaje);
			ini_write_real(_sec, "nivel" + string(i), _lista[i].nivel);
		}
		ini_write_real(_sec, "anonimos", global.anonimos[m]);
	}
	ini_close();
}

/// Borra todos los puntajes y reinicia los contadores de nombres genéricos (y lo guarda)
function scrTopsBorrar(){
	global.tops = [[], []];
	global.anonimos = [0, 0];
	scrTopsGuardar();
}

/// Puesto (empezando en 0) que ocuparía un puntaje en el top del modo, o -1 si no entra.
/// En un empate queda arriba el que llegó primero.
function scrTopsPosicion(_modo, _puntaje){
	scrTopsAsegurar();
	if _puntaje <= 0{
		return -1;
	}
	var _lista = global.tops[_modo - 1];
	var _pos = array_length(_lista);
	for (var i = 0; i < array_length(_lista); i++){
		if _puntaje > _lista[i].puntaje{
			_pos = i;
			break;
		}
	}
	return (_pos < TOP_MAX) ? _pos : -1;
}

/// Agrega una entrada al top del modo y guarda el archivo. Devuelve el puesto (o -1 si no entró).
function scrTopsAgregar(_modo, _nombre, _puntaje, _nivel){
	var _pos = scrTopsPosicion(_modo, _puntaje);
	if _pos < 0{
		return -1;
	}
	var _lista = global.tops[_modo - 1];
	array_insert(_lista, _pos, {
		nombre: _nombre,
		puntaje: _puntaje,
		nivel: _nivel
	});
	if array_length(_lista) > TOP_MAX{
		array_resize(_lista, TOP_MAX);
	}
	scrTopsGuardar();
	return _pos;
}

/// Nombre genérico para quien no escribe nombre: "Jugador N" (1 jugador) o "Equipo N" (2 jugadores).
/// Con _consumir en true se usa el número (el contador sube); en false solo se muestra cuál sería.
function scrNombreGenerico(_modo, _consumir){
	scrTopsAsegurar();
	var _n = global.anonimos[_modo - 1] + 1;
	if _consumir{
		global.anonimos[_modo - 1] = _n;
	}
	return ((_modo == MODO_2J) ? "Equipo " : "Jugador ") + string(_n);
}

/// Quita los caracteres que no sirven en un nombre (control y los que rompen el archivo) y limita el largo
function scrNombreLimpio(_texto){
	var _res = "";
	for (var i = 1; i <= string_length(_texto); i++){
		var _c = string_char_at(_texto, i);
		var _o = ord(_c);
		// Se descartan: control (< 32), DEL, comillas, \, =, ; y corchetes
		if _o >= 32 && _o != 127 && _o != 34 && _o != 92 && _o != 61 && _o != 59 && _o != 91 && _o != 93{
			_res += _c;
		}
	}
	return string_copy(_res, 1, NOMBRE_MAX);
}

/// Dibuja el top de un modo centrado en _cx, con el título en _y.
/// _resaltado: fila (empezando en 0) que se muestra resaltada, o -1 para ninguna.
function scrDibujarTop(_modo, _cx, _y, _resaltado){
	scrTopsAsegurar();
	var _lista = global.tops[_modo - 1];
	var _x0 = _cx - TOPS_ANCHO / 2;
	var _x1 = _cx + TOPS_ANCHO / 2;

	draw_set_valign(fa_middle);
	draw_set_color(c_white);

	// Título y línea
	draw_set_halign(fa_center);
	draw_text_transformed(_cx, _y, "TOP 10 - " + ((_modo == MODO_2J) ? "2 JUGADORES" : "1 JUGADOR"), 1.8, 1.8, 0);
	draw_line(_x0, _y + 24, _x1, _y + 24);

	// Filas
	for (var i = 0; i < TOP_MAX; i++){
		var _fy1 = _y + 30 + i * TOPS_FILA;
		var _fy2 = _fy1 + TOPS_FILA;
		var _cy = (_fy1 + _fy2) / 2;
		var _vacia = (i >= array_length(_lista));

		// La fila resaltada se muestra con relleno blanco y texto negro
		if i == _resaltado{
			draw_set_color(c_white);
			draw_rectangle(_x0, _fy1 + 2, _x1, _fy2 - 2, false);
			draw_set_color(c_black);
		}else if _vacia{
			draw_set_color(c_dkgray);
		}else{
			draw_set_color(c_white);
		}

		draw_set_halign(fa_left);
		draw_text_transformed(_x0 + 10, _cy, string(i + 1) + ".", 1.4, 1.4, 0);
		if _vacia{
			draw_text_transformed(_x0 + 60, _cy, "---", 1.4, 1.4, 0);
		}else{
			draw_text_transformed(_x0 + 60, _cy, _lista[i].nombre, 1.4, 1.4, 0);
			draw_set_halign(fa_right);
			draw_text_transformed(_x1 - 110, _cy, string(_lista[i].puntaje), 1.4, 1.4, 0);
			draw_text_transformed(_x1 - 10, _cy, "NIV " + string(_lista[i].nivel), 1.4, 1.4, 0);
		}
	}

	// Restaurar valores por defecto
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
}

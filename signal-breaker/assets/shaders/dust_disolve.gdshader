shader_type canvas_item;

instance uniform float seed: hint_range(0.01, 1.0) = 0.5;
instance uniform float progress: hint_range(0.0, 1.0) = 0.0; // Añadido para control manual

instance uniform vec2 direction = vec2(-0.5,0.);
instance uniform float mask_vignette_strength: hint_range(0.0, 1.0) = 0.5;
instance uniform vec2 mask_vignette_center = vec2(0.5,0.3);

// From https://godotshaders.com/snippet/random-value/
float random (vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment() {
	if (progress > 0.0) {
		vec2 center = vec2(0.5);
		// Usamos una semilla diferente para X e Y para evitar movimiento puramente diagonal
		vec2 offset = vec2(random(UV * seed), random(UV * seed + 0.1));
		offset.x = clamp(offset.x,0.,0.5);
		offset.y = clamp(offset.y,0.,1.5);

		// Ahora el progreso de la animación lo dicta la variable 'progress'
		float t = progress;

		// Restamos el desplazamiento para que la dirección sea intuitiva.
		// Al restar un vector negativo, se suma a la UV, desplazando el muestreo y moviendo la imagen correctamente.
		vec2 offset_uv = UV - (direction + offset * 0.1) * t;

		float circle_clip = distance(UV,mask_vignette_center);
		COLOR = texture(TEXTURE, offset_uv);

		// Clamp para evitar que el alfa se rompa y control de desvanecimiento
		float fade = clamp(t, 0.0, 1.0);
		COLOR.a -= fade + (circle_clip * mask_vignette_strength);
	}
}

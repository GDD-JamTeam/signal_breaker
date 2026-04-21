shader_type canvas_item;

// Mantenemos el control del desenfoque
instance uniform float blur_amount : hint_range(0.0, 5.0) = 2.0;
// Añadimos una variable para elegir el color de tinte
instance uniform vec4 tint_color : source_color = vec4(0.0, 0.0, 0.0, 0.5); // Por defecto: negro semitransparente
// Añadimos control sobre cuánto afecta el tinte (0.0 = solo blur, 1.0 = solo color)
instance uniform float tint_strength : hint_range(0.0, 1.0) = 0.5;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	// 1. Obtenemos la imagen de fondo desenfocada
	vec4 blurred_screen = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount);
	
	// 2. Mezclamos el blur con el color de tinte usando tint_strength
	// mix(A, B, t) interpola linealmente entre A y B basado en t
	vec3 final_color = mix(blurred_screen.rgb, tint_color.rgb, tint_strength);
	
	// 3. Mantenemos el alpha original de la textura de pantalla (normalmente 1.0)
	// O podrías multiplicarlo por tint_color.a si quieres un control extra de opacidad general
	COLOR = vec4(final_color, blurred_screen.a);
}
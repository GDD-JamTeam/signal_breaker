shader_type canvas_item;

uniform float vignette_strength = 1.2;
uniform float noise_strength = 0.09;
uniform float scanline_strength = 0.04;
uniform float washout = 0.15;

float random(vec2 uv){
	return fract(sin(dot(uv ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment(){

	vec2 uv = UV;
	vec4 color = texture(TEXTURE, uv);

	color.rgb = mix(color.rgb, vec3(0.8), washout);

	float dist = distance(uv, vec2(0.5));
	float vignette = smoothstep(0.8, vignette_strength, dist);

	float noise = random(uv * TIME) * noise_strength;

	float scanlines = sin(UV.y * 800.0) * scanline_strength;

	vec3 final = color.rgb - vignette;
	final += noise;
	final += scanlines;

	COLOR = vec4(final, color.a);
}
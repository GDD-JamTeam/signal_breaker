shader_type canvas_item;

uniform float vignette_strength = 1.2;
uniform float noise_strength = 0.03;
uniform float scanline_strength = 0.04;
uniform float washout = 0.15;
uniform float dust_strength = 0.35;

float random(vec2 uv){
	return fract(sin(dot(uv ,vec2(12.9898,78.233))) * 43758.5453);
}

float dust_spot(vec2 uv, vec2 pos, float size){
	float d = distance(uv, pos);
	return smoothstep(size, size * 0.4, d);
}

void fragment(){

	vec2 uv = UV;
	vec4 color = texture(TEXTURE, uv);

	color.rgb = mix(color.rgb, vec3(0.8), washout);


	float dist = distance(uv, vec2(0.5));
	float vignette = smoothstep(0.8, vignette_strength, dist);

	float noise = random(uv * TIME) * noise_strength;

	float scanlines = sin(UV.y * 800.0) * scanline_strength;

	float dust = 0.0;
	dust += dust_spot(uv, vec2(0.3,0.4), 0.06);
	dust += dust_spot(uv, vec2(0.65,0.55), 0.05);
	dust += dust_spot(uv, vec2(0.5,0.3), 0.04);

	vec3 final = color.rgb;

	final -= vignette;
	final -= dust * dust_strength;

	final += noise;
	final += scanlines;

	COLOR = vec4(final, color.a);
}

shader_type canvas_item;

uniform float flicker_strength = 0.05;
uniform float grain_strength = 0.08;
uniform float line_strength = 0.1;
uniform float image_jitter = 0.002;

float random(vec2 uv){
    return fract(sin(dot(uv, vec2(12.9898,78.233))) * 43758.5453);
}

void fragment(){

    vec2 uv = UV;

    uv.x += sin(TIME * 40.0) * image_jitter;

    vec4 color = texture(TEXTURE, uv);

    float flicker = 1.0 + sin(TIME * 50.0) * flicker_strength;

    float grain = random(uv * TIME) * grain_strength;

    float lines = sin(UV.y * 600.0) * line_strength;

    vec3 sepia;
    sepia.r = dot(color.rgb, vec3(0.393, 0.769, 0.189));
    sepia.g = dot(color.rgb, vec3(0.349, 0.686, 0.168));
    sepia.b = dot(color.rgb, vec3(0.272, 0.534, 0.131));

    vec3 final = sepia;

    final += grain;
    final += lines;

    COLOR = vec4(final * flicker, color.a);
}

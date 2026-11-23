
shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(0.3, 0.7, 1.0, 1.0);
uniform float glow_strength = 0.7;
uniform float glow_speed = 2.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    float pulse = 0.5 + 0.5 * sin(TIME * glow_speed);

    vec3 glow = glow_color.rgb * glow_strength * pulse;

    COLOR = vec4(
        tex.rgb + glow * tex.a,
        tex.a
    );
}

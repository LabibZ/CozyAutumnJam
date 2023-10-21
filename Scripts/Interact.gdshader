shader_type canvas_item;
uniform float tint_strength : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	COLOR.rgb = mix(COLOR.rgb, vec3(1.0, 1.0, 1.0), tint_strength);
}

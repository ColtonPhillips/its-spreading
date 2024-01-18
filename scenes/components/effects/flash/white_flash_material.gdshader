shader_type canvas_item;
render_mode unshaded;

uniform float tween : hint_range(0, 1.0) = 0.0;

void fragment() {
	// Output white for every pixel but kee the alpha
	vec4 input = texture(TEXTURE, UV);
	COLOR = vec4(max(input.r, 1.0 - tween), max(input.g, 1.0 - tween), max(input.b, 1.0 - tween), input.a);
}

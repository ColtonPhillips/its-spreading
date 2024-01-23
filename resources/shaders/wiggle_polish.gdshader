shader_type canvas_item;

uniform float fire_intensity : hint_range(0.0, 1.0) = 0.0;
uniform float animation_intensity : hint_range(0.0, 4.0) = 0.0;
uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
void vertex() {
    // Add a subtle animation using a sin wave
    //vec2 offset = vec2(sin(TIME * 2.0), 0.0) * 0.05;
    //VERTEX += vec2(offset.x, offset.y);
	
    // Calculate layer-specific offset
	
	    // Add a subtle animation using a sin wave
    vec2 offset = vec2(sin(TIME * 1.0) * animation_intensity, 0.0);
    vec2 layer_offset = offset * (1.0 / 10.0) * -VERTEX.y;
    VERTEX += vec2(offset.y, offset.x) + layer_offset;
	COLOR.r += layer_offset.y;
}

void fragment() {
    vec4 fire_color = vec4(1.0, 0.0, 0.0, COLOR.a);

    COLOR = mix(COLOR, fire_color, fire_intensity);
}
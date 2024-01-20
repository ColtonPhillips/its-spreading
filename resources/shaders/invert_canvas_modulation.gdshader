shader_type canvas_item;

uniform vec4 canvas_modulate : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void vertex() {
    // Nothing here for 2D shaders
}

void fragment() {
    // Reverse the CanvasModulate effect
    COLOR.rgb /= canvas_modulate.rgb;
}
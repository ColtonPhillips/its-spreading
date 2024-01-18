shader_type canvas_item;

void fragment() {
    // Set the output color to the texture color without considering lighting.
    COLOR = texture(TEXTURE, UV);
}
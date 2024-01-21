shader_type canvas_item;

uniform vec2 screen_size;
uniform float time;

void fragment() {
    // Get the pixel coordinates in UV space
    vec2 uv = FRAGCOORD.xy / screen_size;

    // Simulate rising smoke using Perlin noise
    float turbulence = (sin(uv.x * 10.0 + time) + sin(uv.y * 10.0 + time)) * 0.1;
    uv.y += turbulence;

    // Sample the original sky texture
    vec4 originalColor = texture(TEXTURE, uv);

    // Output the final color with the modified UV
    COLOR = originalColor;
}
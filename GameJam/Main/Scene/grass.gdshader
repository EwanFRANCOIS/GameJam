shader_type canvas_item;

// Nouvelle variable pour recevoir la texture de bruit depuis l'inspecteur
uniform sampler2D noise_texture : repeat_enable;
uniform float grass_details = 2.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 noise_uv = (UV * grass_details);
	float noise_value = texture(noise_texture, noise_uv).r;
	vec3 color_A = vec3(34.0, 149.0, 13.0) / 255.0;  // Vert clair
    vec3 color_B = vec3(12.0, 72.0, 3.0) / 255.0;   // Vert foncé
    
    // 2. Mixer les deux couleurs selon la noise_value (qui est entre 0.0 et 1.0)
    // Si noise_value vaut 0.0 -> color_A
    // Si noise_value vaut 1.0 -> color_B
    // Si noise_value vaut 0.5 -> un mélange parfait des deux
    vec3 mixed_colors = mix(color_A, color_B, noise_value);
	COLOR = vec4(mixed_colors.x, mixed_colors.y, mixed_colors.z, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

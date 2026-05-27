shader_type canvas_item;

// On définit le nombre maximum de lumières énumérées
const int MAX_LIGHTS = 10; 
// C'est ICI qu'on crée le tableau de Vector2
uniform vec3 light_positions[MAX_LIGHTS]; 

// On passe aussi le nombre de lumières actuellement visibles à l'écran
uniform int light_count = 0;

// Nouvelle variable pour recevoir la texture de bruit depuis l'inspecteur
uniform sampler2D noise_texture : repeat_enable;
// Variable pour contrôler la vitesse du mouvement du brouillard
uniform vec2 fog_speed = vec2(0.03, 0.01);

void fragment() {
	// Called for every pixel the material is visible on.
	float aspect_ratio = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
    float total_light = 0.0;
	
    vec2 noise_uv = UV + TIME * fog_speed; // TIME pour animer le brouillard
    float noise_value = texture(noise_texture, noise_uv).r;
	
	// Ajuster l'UV actuel pour corriger la déformation de l'écran
    vec2 corrected_uv = UV;
    corrected_uv.x *= aspect_ratio; // On étire virtuellement l'axe X pour qu'il soit à la même échelle que Y
    
    // On boucle sur toutes les lumières actives
    for (int i = 0; i < light_count; i++) {
		// Il faut AUSSI ajuster la position de la lumière avec le même ratio !
        vec2 corrected_light_pos = light_positions[i].xy;
        corrected_light_pos.x *= aspect_ratio;
		
		float custom_radius = light_positions[i].z; // 0.6 for player, 0.3 for objects
		
        float dist = distance(corrected_uv, corrected_light_pos);
		float dynamic_radius = (custom_radius-0.05) + (noise_value * 0.05);
        float light_zone = smoothstep(dynamic_radius, 0.0, dist);
        total_light += light_zone;
    }
	
	// 3. Appliquer le bruit sur l'opacité globale du brouillard restant
    // Pour que les zones sombres ne soient pas un noir uni, mais un motif de brume
    float base_fog = 0.8+0.3*noise_value;
    
    // On soustrait la lumière accumulée au brouillard texturé
    float final_fog = clamp(base_fog - total_light, 0.0, 0.85);
    
    COLOR = vec4(0.0, 0.0, 0.0, final_fog);
}
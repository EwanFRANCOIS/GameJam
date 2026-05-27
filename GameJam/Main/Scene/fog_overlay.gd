extends ColorRect

@export var lights: Array[Node2D] = []

func _process(_delta: float) -> void:
	var positions_array = []
	var viewport_size = get_viewport_rect().size
	
	# On définit une marge (0.2 = 20% de la taille de l'écran en plus tout autour)
	var margin = 1
	
	for light in lights:
		if light and light.is_visible_in_tree():
			var screen_pos = light.get_global_transform_with_canvas().origin
			var percent_pos = screen_pos / viewport_size
			
			# VÉRIFICATION : Est-ce que la lumière est dans l'écran (+ la marge) ?
			var is_on_screen_x = percent_pos.x >= -margin and percent_pos.x <= 1.0 + margin
			var is_on_screen_y = percent_pos.y >= -margin and percent_pos.y <= 1.0 + margin
			
			if is_on_screen_x and is_on_screen_y:
				
				var radius = 0.2
				if light.has_meta("light_radius"):
					radius = light.get_meta("light_radius")
				# Pack everything into a Vector3(X, Y, Radius)
				var light_data = Vector3(percent_pos.x, percent_pos.y, radius)
				
				positions_array.append(light_data)
				
				# Sécurité pour ne pas dépasser la taille du tableau du shader
				if positions_array.size() >= 10:
					break
	
	# On envoie les données filtrées au shader
	material.set_shader_parameter("light_positions", positions_array)
	material.set_shader_parameter("light_count", positions_array.size())

extends TextureProgressBar

@onready var label_temps = $Label # Ton nœud de texte enfant

@export var temps_cooldown_total : float = 5.0 # Durée du cooldown en secondes
var temps_restant : float = 0.0
var en_cooldown : bool = false

func _ready():
	# Initialise la jauge (vide au départ)
	value = 0
	label_temps.text = ""

func _process(delta):
	if en_cooldown:
		temps_restant -= delta
		
		if temps_restant <= 0:
			# Fin du cooldown
			en_cooldown = false
			value = 0
			label_temps.text = ""
		else:
			# Met à jour le texte (affiche 1 chiffre après la virgule, ex: 3.4)
			label_temps.text = str(snapped(temps_restant, 0.1))
			
			# Met à jour la jauge visuelle (en pourcentage entre 0 et max_value)
			value = (temps_restant / temps_cooldown_total) * max_value

# Fonction à appeler depuis ton script de joueur quand il utilise la compétence
func lancer_cooldown():
	if not en_cooldown:
		temps_restant = temps_cooldown_total
		en_cooldown = true

extends Node2D

var current_state: State
var previous_state: State

func _ready():
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.enter()

func change_state(state):
	if (current_state and state == current_state.name):
		return
	
	if state == previous_state.name:
		return
	
	var new_state = find_child(state) as State
	if (new_state):
		current_state = new_state
		current_state.enter() 
		
		if (state == "Idle"):
			current_state.process_mode = Node.PROCESS_MODE_ALWAYS
		else:
			current_state.process_mode = Node.PROCESS_MODE_INHERIT
	
	if (previous_state):
		previous_state.exit()
	previous_state = current_state

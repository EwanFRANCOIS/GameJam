extends State

func enter():
	super.enter()
	owner.alpha = 0.2

func transition():
	if can_transition:
		get_parent().change_state("3leaf")

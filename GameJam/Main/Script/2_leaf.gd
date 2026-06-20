extends State

func enter():
	var AttackSpeed = $"../../Speed"
	super.enter()
	owner.alpha = 5
	AttackSpeed.wait_time = 0.08

func transition():
	if can_transition:
		get_parent().change_state("5leaf")

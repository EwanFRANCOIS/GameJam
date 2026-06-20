extends State

func enter():
	var AttackSpeed = $"../../Speed"
	super.enter()
	owner.alpha = 10
	AttackSpeed.wait_time = 0.2

func transition():
	if can_transition:
		get_parent().change_state("2leaf")

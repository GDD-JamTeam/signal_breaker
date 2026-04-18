extends base_entity


func get_attack_animation() -> String:
	match attack_index:
		0:
			return "attack_1"
		1:
			return "attack_2"
		2:
			return "attack_3"
	
	return "attack_1"

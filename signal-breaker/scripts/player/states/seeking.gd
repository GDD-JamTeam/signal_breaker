class_name PlayerSeeking extends EntitySeeking


func physics_update(delta: float) -> void:
	super(delta)
	if (
		Input.is_action_just_pressed("attack_1") or
		Input.is_action_just_pressed("attack_2") or
		Input.is_action_just_pressed("attack_3")
	): to_state.emit(PlayerAttack)

	base_entity.update_velocity(base_entity.input_dir)

class_name EntityAttack extends EntityState

func start() -> void:
	# Se pasa a Rest si acaba la animación usando una señal
	base_entity.animation_sprite.animation_finished.connect(
		func(): to_state.emit(EntityRest),
		CONNECT_ONE_SHOT
	)


func physics_update(_delta: float) -> void:
	update_attack_hitbox()


func exit() -> void:
	base_entity.disable_hitboxes()
	base_entity.hitbox_active = false


func update_attack_hitbox() -> void:
	var current_frame := base_entity.animation_sprite.frame
	var attack_range := base_entity.get_attack_frame_range()

	if attack_range.size() < 2: return

	var start_frame = attack_range[0]
	var end_frame = attack_range[1]

	if current_frame >= start_frame and current_frame <= end_frame:
		if not base_entity.hitbox_active:
			base_entity.enable_hitbox(base_entity.attack_index)
			base_entity.hitbox_active = true
	else:
		if base_entity.hitbox_active:
			base_entity.disable_hitboxes()
			base_entity.hitbox_active = false

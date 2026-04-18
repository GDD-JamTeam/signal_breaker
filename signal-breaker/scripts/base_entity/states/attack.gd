class_name EntityAttack extends EntityState


## Índice de la animación de ataque
var attack_index: int = 0


func start() -> void:
	# Se pasa a Seeking si acaba la animación usando una señal
	base_entity.animation_sprite.animation_finished.connect(func(): to_state.emit(EntitySeeking))


func physics_update(_delta: float) -> void:
	update_attack_hitbox()


func update_attack_hitbox() -> void:
	var frame := base_entity.animation_sprite.frame
	var attack_range := []

	if attack_range.size() < 2: return

	var start_frame = attack_range[0]
	var end_frame = attack_range[1]

	if frame >= start_frame and frame <= end_frame:
		if not base_entity.hitbox_active:
			base_entity.enable_damage_box(base_entity.attack_index)
			base_entity.hitbox_active = true
	else:
		if base_entity.hitbox_active:
			base_entity.disable_damage_box()
			base_entity.hitbox_active = false
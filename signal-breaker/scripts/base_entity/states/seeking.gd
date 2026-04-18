class_name EntitySeeking extends EntityState


func start() -> void:
	await base_entity.ready
	base_entity.animation_sprite.play(&"idle")


func physics_update(_delta: float) -> void:
	update_animation()
	if Input.is_action_just_pressed("attack"): to_state.emit(PlayerAttack)


## Actualiza la animación del personaje dependiendo de su dirección y velocidad
func update_animation() -> void:
	var new_anim := &"walk" if base_entity.velocity.length() > 10 else &"idle"
	base_entity.animation_sprite.play(new_anim)
	base_entity.animation_sprite.flip_h = base_entity.is_looking_right

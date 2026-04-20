class_name EntitySeeking extends EntityState


func start() -> void:
	await base_entity.ready
	base_entity.animation_sprite.play(&"idle")


func physics_update(_delta: float) -> void:
	update_animation()


## Actualiza la animación del personaje dependiendo de su dirección y velocidad
func update_animation() -> void:
	var new_anim := &"walk" if base_entity.velocity.length() > 10 else &"idle"
	base_entity.animation_sprite.play(new_anim)
	base_entity.animation_sprite.flip_h = base_entity.is_looking_right

	# Voltea los ataques también
	base_entity.hitboxes_node.scale.x = 1 if not base_entity.is_looking_right else -1
	base_entity.hitbox_node.scale.x = 1 if not base_entity.is_looking_right else -1

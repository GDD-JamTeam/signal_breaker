## Estado de la entidad para cuando recibe daño
class_name EntityStunned extends EntityState


func start() -> void:
	base_entity.animation_sprite.play(&"hurt")
	base_entity.animation_sprite.flip_h = base_entity.is_looking_right
	base_entity.hitboxes_node.scale.x = 1 if not base_entity.is_looking_right else -1
	base_entity.hitbox_node.scale.x = 1 if not base_entity.is_looking_right else -1
	
	base_entity.play_sound_by_key("hurt")
	# Espera a que acabe el tiempo de aturdimiento y se pasa al estado anterior
	await get_tree().create_timer(base_entity.knockback_duration).timeout
	to_state.emit(base_entity.get_default_state())

func exit() -> void:
	base_entity.stop_sound()

func physics_update(_delta: float) -> void:
	# Detiene a la entidad
	# base_entity.velocity = base_entity.knockback_force * base_entity.knockback_dir * Vector2.RIGHT
	pass

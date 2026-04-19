## Estado de la entidad para cuando recibe daño
class_name EntityStunned extends EntityState


func start() -> void:
	base_entity.animation_sprite.play(&"hurt")

	# Espera a que acabe el tiempo de aturdimiento y se pasa al estado anterior
	await get_tree().create_timer(base_entity.knockback_duration).timeout
	to_state.emit(base_entity.previous_state)


func physics_update(_delta: float) -> void:
	# Detiene a la entidad
	base_entity.velocity = Vector2.ZERO

## Estado de la entidad para cuando acaba un ataque
class_name EntityRest extends EntityState

func start() -> void:
	base_entity.animation_sprite.play(&"idle")

	# Espera a que acabe el tiempo de aturdimiento y se pasa al estado anterior
	await get_tree().create_timer(base_entity.rest_duration).timeout
	to_state.emit(EntitySeeking)


func physics_update(_delta: float) -> void:
	# Detiene a la entidad
	base_entity.velocity = Vector2.ZERO

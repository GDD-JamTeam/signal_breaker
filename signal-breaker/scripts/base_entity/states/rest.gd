## Estado de la entidad para cuando acaba un ataque
class_name EntityRest extends EntityState

func start() -> void:
	base_entity.animation_sprite.play(&"idle")
	
	base_entity.play_sound_by_key("rest")

	# Espera a que acabe el tiempo de aturdimiento y se pasa al estado anterior
	await get_tree().create_timer(base_entity.rest_duration).timeout
	to_state.emit(EntitySeeking)

func exit() -> void:
	base_entity.stop_sound()

func physics_update(_delta: float) -> void:
	# Detiene a la entidad
	base_entity.velocity = Vector2.ZERO

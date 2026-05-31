class_name EnemySeeking extends EntitySeeking


## Objetivo, típicamente el jugador
var target: BaseEntity


func start() -> void:
	super()

	# Esperamos a que el enemigo esté listo para obtener su objetivo
	await base_entity.ready
	if &"target" in base_entity: target = base_entity.target


func physics_update(_delta: float) -> void:
	if base_entity.range:
		to_state.emit(EntityCharge)
	elif target != null:
		var offset_x := 40.0 # distancia lateral deseada

		var dir_x: int = sign(base_entity.global_position.x - target.global_position.x)
		if dir_x == 0:
			dir_x = 1 if randf() > 0.5 else -1

		var desired_pos := target.global_position + Vector2(dir_x * offset_x, 0)
		base_entity.move_to(desired_pos)

	update_animation()


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

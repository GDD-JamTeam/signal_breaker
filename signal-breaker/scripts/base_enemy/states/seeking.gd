class_name EnemySeeking extends EntitySeeking

var target: BaseEntity

# Called when the node enters the scene tree for the first time.
func start() -> void:
	super()
	await base_entity.ready
	if base_entity.has_method("get_target"):
		target = base_entity.get_target()

func physics_update(_delta: float) -> void:
	if base_entity.get_on_range():
		to_state.emit(EntityCharge)
	elif target != null:
		var offset_x := 40.0 # distancia lateral deseada
		
		var dir_x : int = sign(base_entity.global_position.x - target.global_position.x)
		if dir_x == 0:
			dir_x = 1 if randf() > 0.5 else -1
		
		var desired_pos := target.global_position + Vector2(dir_x * offset_x, 0)
		
		base_entity.move_to(desired_pos)
	
	update_animation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

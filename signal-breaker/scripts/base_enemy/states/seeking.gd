class_name EnemySeeking extends EntitySeeking

var target: BaseEntity

# Called when the node enters the scene tree for the first time.
func start() -> void:
	super()
	if base_entity.has_method("get_target"):
		target = base_entity.get_target()

func physics_update(_delta: float) -> void:
	if base_entity.get_on_range():
		to_state.emit(EntityCharge)
	elif target != null:
		base_entity.move_to(target.position)
	
	update_animation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

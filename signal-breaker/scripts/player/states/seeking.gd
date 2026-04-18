class_name PlayerSeeking extends EntitySeeking


func physics_update(delta: float) -> void:
	super(delta)
	base_entity.move_direction(base_entity.input_dir)

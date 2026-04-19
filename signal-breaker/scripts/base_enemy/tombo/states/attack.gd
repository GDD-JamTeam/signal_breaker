class_name TomboAttack extends EntityAttack


func start() -> void:
	super()
	if base_entity.has_method("fire_tickets"):
		base_entity.fire_tickets()

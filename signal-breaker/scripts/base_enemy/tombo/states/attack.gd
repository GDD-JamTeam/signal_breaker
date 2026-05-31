class_name TomboAttack extends EntityAttack


var fired := false


func start() -> void:
	fired = false
	super()


func update_attack_hitbox() -> void:
	super()
	var current_frame := base_entity.animation_sprite.frame
	var attack_range := base_entity.get_current_attack_frame_range()

	if attack_range.size() < 2: return

	var start_frame = attack_range[0]
	if current_frame != start_frame or fired: return
	if base_entity.has_method(&"fire_tickets"):
		base_entity.fire_tickets()
		fired = true

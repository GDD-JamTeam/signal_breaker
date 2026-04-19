class_name PlayerAttack extends EntityAttack


func start() -> void:
	# Ejecuta el inicio de EntityAttack
	super()

	# Configura las hitbox
	base_entity.hit_targets.clear()
	base_entity.hitbox_active = false

	# Elige una animación dependiendo del input
	base_entity.animation_sprite.play(get_attack_animation())


func physics_update(_delta: float) -> void:
	super(_delta)
	base_entity.velocity = Vector2.ZERO


## Obtiene el nombre la animación de ataque
func get_attack_animation() -> String:
	if Input.is_action_just_pressed("attack_1"): base_entity.attack_index = 0
	elif Input.is_action_just_pressed("attack_2"): base_entity.attack_index = 1
	elif Input.is_action_just_pressed("attack_3"): base_entity.attack_index = 2
	else: return "idle"

	return "attack_%s" % (base_entity.attack_index + 1)

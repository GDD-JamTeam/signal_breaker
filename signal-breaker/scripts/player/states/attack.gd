class_name PlayerAttack extends EntityAttack


func start() -> void:
	# Ejecuta el inicio de EntityAttack
	super()

	# Configura las hitbox
	base_entity.hit_targets.clear()
	base_entity.hitbox_active = false

	# Elige una animación al azar
	var attack_count = base_entity.attack_frames.size()
	base_entity.attack_index = randi() % attack_count
	base_entity.animation_sprite.play(get_attack_animation())


func physics_update(_delta: float) -> void:
	super(_delta) # Esto permite que EntityAttack gestione las hitboxes
	base_entity.velocity = Vector2.ZERO


## Obtiene el nombre la animación de ataque
func get_attack_animation() -> String:
	return "attack_%s" % (base_entity.attack_index + 1)

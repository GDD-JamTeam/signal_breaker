class_name PlayerAttack extends EntityAttack


## Frames a los que se ataca, como rangos
var attack_frames = [
	[2, 3], # attack_1
	[4, 6], # attack_2
	[6, 9] # attack_3
]


func start() -> void:
	# Ejecuta el inicio de EntityAttack
	super()

	# Configura las hitbox
	base_entity.hit_targets.clear()
	base_entity.hitbox_active = false

	# Elige una animación al azar
	attack_index = randi_range(1, 3)
	base_entity.animation_sprite.play(get_attack_animation())


func physics_update(_delta: float) -> void:
	base_entity.velocity = Vector2.ZERO


## Obtiene el nombre la animación de ataque
func get_attack_animation() -> String:
	return "attack_%s" % attack_index


## Obtiene el rango de frames de ataque
func get_attack_frame_range() -> Array:
	return attack_frames[attack_index]

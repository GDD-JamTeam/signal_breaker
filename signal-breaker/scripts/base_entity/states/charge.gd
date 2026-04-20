## Estado de la entidad para cuando carga antes de atacar
class_name EntityCharge extends EntityState

var timer: Timer


func start() -> void:
	base_entity.animation_sprite.play(&"idle")

	# Crear timer controlado
	timer = Timer.new()
	timer.wait_time = base_entity.charge_duration
	timer.one_shot = true
	
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	
	timer.start()


func exit() -> void:
	if timer:
		timer.stop()
		timer.queue_free()
		timer = null


func _on_timer_timeout() -> void:
	to_state.emit(base_entity.get_attack_state())


func physics_update(_delta: float) -> void:
	# Detiene a la entidad
	base_entity.velocity = Vector2.ZERO
	update_animation()


## Actualiza la animación del personaje dependiendo de su dirección y velocidad
func update_animation() -> void:
	base_entity.animation_sprite.play(&"idle")

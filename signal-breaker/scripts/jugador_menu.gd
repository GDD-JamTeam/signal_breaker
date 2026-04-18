extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta):
	# Obtener la dirección basada en las acciones por defecto de Godot
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	velocity.x = direction_x * SPEED
	velocity.y = direction_y * SPEED

	move_and_slide()

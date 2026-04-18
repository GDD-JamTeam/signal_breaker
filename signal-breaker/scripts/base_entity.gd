extends CharacterBody2D
class_name base_entity

@export var health: int = 100
@export var speed: int


func _ready() -> void:
	pass

func move_to(pos: Vector2) -> void:
	pass
	
func move_direction(dir: Vector2) -> void:
	pass
	
func die() -> void:
	pass
	
func get_hurt() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	

	move_and_slide()

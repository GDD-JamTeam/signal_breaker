extends Node2D

@export var parent_node: Node
@export var spawn_node: Node2D
@export var animated_sprite: AnimatedSprite2D
@export var collision_shape: CollisionShape2D
@export var trigger_area: Area2D

# 🔥 lista de enemigos
@export var enemies: Array[EnemyData]
@export var selected_index: int = 0

@export var min_scale: float = 0.25
@export var max_scale: float = 0.5
@export var radius: float = 50.0

var triggered := false
var tween: Tween


func get_enemy_data() -> EnemyData:
	if enemies.is_empty():
		push_error("[Spawner] No hay enemigos configurados")
		return null
	
	selected_index = clamp(selected_index, 0, enemies.size() - 1)
	return enemies[selected_index]


func _ready() -> void:
	var data = get_enemy_data()
	if data == null:
		return
	
	# radio
	if collision_shape.shape is CircleShape2D:
		collision_shape.shape.radius = radius
	
	# escala inicial
	animated_sprite.scale = Vector2.ONE * min_scale
	
	# anim inicial
	if data.animation != "":
		animated_sprite.play(data.animation)


func _on_spawn_signal_advertisment_area_entered(area: Area2D) -> void:
	if triggered:
		return
	
	if not area.is_in_group("player"):
		return
	
	triggered = true
	trigger_area.set_deferred("monitoring", false)

	start_telegraph_and_spawn()


func start_telegraph_and_spawn() -> void:
	var data = get_enemy_data()
	if data == null:
		return
	
	if tween:
		tween.kill()
	
	tween = get_tree().create_tween()
	
	var duration : float = max(data.scale_time, 0.01)
	
	tween.tween_property(
		animated_sprite,
		"scale",
		Vector2.ONE * max_scale,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	await tween.finished
	
	if data.spawn_delay_after_scale > 0.0:
		await get_tree().create_timer(data.spawn_delay_after_scale).timeout
	
	spawn_enemy(data)


func spawn_enemy(data: EnemyData) -> void:
	var enemy := data.scene.instantiate()
	enemy.global_position = spawn_node.global_position
	
	# 🔥 limpiar visual
	animated_sprite.play("empty")
	animated_sprite.visible = false
	
	# 🔥 decidir padre
	var parent: Node = parent_node if is_instance_valid(parent_node) else get_tree().current_scene
	
	parent.add_child(enemy)
	

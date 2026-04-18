extends Label

var hits:int = 0
var tween_pop: Tween
var reset_timer: Timer
var reset_token: int

func _ready() -> void:
	# Conectar con señal de cuando recibe daño un enemigo
	self.scale = Vector2.ZERO
	self.text = ""
	
	reset_timer = Timer.new()
	reset_timer.wait_time = 2.0
	reset_timer.one_shot = true
	reset_timer.timeout.connect(reset_counter)
	add_child(reset_timer)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		actualizar_contador()

func actualizar_contador() -> void:
	hits += 1
	self.text = "x" + str(hits)
	animacion_pop(hits)
	
	reset_token += 1
	
	reset_timer.stop()
	reset_timer.start()
	
func animacion_pop(hits) -> void:
	if tween_pop:
		tween_pop.kill()
	
	tween_pop = get_tree().create_tween()
	var tilt = deg_to_rad(randf_range(-20, 20))
	var scale_factor = randf_range(3, 3.5)
	
	if hits % 10 == 0:
		scale_factor*=1.3
	
	tween_pop.parallel().tween_property(self, "scale", Vector2.ONE*scale_factor, 0.1).set_trans(Tween.TRANS_EXPO)
	tween_pop.parallel().tween_property(self, "rotation", tilt, 0.1)
	tween_pop.tween_property(self, "scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_BACK)
	
func reset_counter() -> void:
	var tween_reset = get_tree().create_tween()
	var mi_token = reset_token
	
	tween_reset.tween_property(self, "scale", Vector2.ZERO, 0.1)
	await tween_reset.finished
	
	if mi_token != reset_token:
		return
	
	self.text = ""
	hits = 0

extends Label

var hits:int = 0

func _ready() -> void:
	# Conectar con señal de cuando recibe daño un enemigo
	scale = Vector2.ZERO
	modulate.a = 0.0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		actualizar_contador()
	
func actualizar_contador():
	hits += 1
	self.text = "x" + str(hits)
	animacion_pop(hits)
	
func animacion_pop(hits):
	var tween_pop = get_tree().create_tween()
	var tilt = deg_to_rad(randf_range(-20, 20))
	var scale_factor = randf_range(3, 3.5)
	
	if hits % 10 == 0:
		scale_factor*=1.2
	
	modulate.a = 1.0
	tween_pop.parallel().tween_property(self, "scale", Vector2.ONE*scale_factor, 0.1).set_trans(Tween.TRANS_EXPO)
	tween_pop.parallel().tween_property(self, "rotation", tilt, 0.1)
	tween_pop.tween_property(self, "scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_BACK)

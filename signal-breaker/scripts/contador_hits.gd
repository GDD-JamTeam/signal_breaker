extends Label

var hits:int = 0

func _ready() -> void:
	# Conectar con señal de cuando recibe daño un enemigo
	pass 

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		actualizar_contador()
	
func actualizar_contador():
	animacion_pop()
	hits += 1
	self.text = str(hits) + "x"
	
func animacion_pop():
	var tween_pop = get_tree().create_tween()
	var tilt = deg_to_rad(randf_range(-20, 20))
	var scale_factor = randf_range(3, 3.5)
	
	tween_pop.parallel().tween_property(self, "scale", scale*scale_factor, 0.1).set_trans(Tween.TRANS_EXPO)
	tween_pop.parallel().tween_property(self, "rotation", tilt, 0.1)
	tween_pop.tween_property(self, "scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_BACK)

extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RawSteak.self_modulate.a8 = 255
	$RawSteak/SteakOverlay.self_modulate.a8 = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(.1).timeout
	self.self_modulate.a8 = 255
	$RawSteak.self_modulate.a8 -= 1
	$RawSteak/SteakOverlay.self_modulate.a8 += 1

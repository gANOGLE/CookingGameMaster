extends Button
var new_scene = load("res://tscn/Scenes/CuttingMinigame.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_start_cutting)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CustomerName.text = Global.CustomerName
	
func _start_cutting():
	print("E")
	get_parent().get_parent().add_child(new_scene)  # adds as child of current node
	new_scene.position = Vector2(0, 0)

extends Sprite2D


@onready var knife: Sprite2D = $"."
var cuts_done = 0
var knife_direction = 8
var current_line = 1
@onready var guidline_1: Sprite2D = $"../CuttingGuidline1"
@onready var guidline_2: Sprite2D = $"../CuttingGuidline2"
@onready var guidline_3: Sprite2D = $"../CuttingGuidline3"
const ACTION_NAME = "CUTTING_MINIGAME_DEBUG"

func _ready() -> void:
	guidline_2.hide()
	guidline_3.hide()

func _process(_delta: float) -> void:
	knife.position.x += knife_direction
	if knife.position.x < -480 or knife.position.x > 480:
		knife_direction *= -1

func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and current_line == 1:
		Global.distance_1 = abs(guidline_1.position.x - knife.position.x)
		guidline_1.hide()
		guidline_2.show()
		current_line = 2

		
		while not Input.is_action_just_released("CUTTING_MINIGAME_DEBUG"):
			await get_tree().process_frame
			
		
		while not Input.is_action_pressed("CUTTING_MINIGAME_DEBUG"):
			await get_tree().process_frame

		Global.distance_2 = abs(guidline_2.position.x - knife.position.x)
		guidline_2.hide()
		guidline_3.show()
		current_line = 3
		
		while not Input.is_action_just_released("CUTTING_MINIGAME_DEBUG"):
			await get_tree().process_frame
			
		
		while not Input.is_action_pressed("CUTTING_MINIGAME_DEBUG"):
			await get_tree().process_frame
			
		Global.distance_3 = abs(guidline_3.position.x - knife.position.x)
		guidline_3.hide()
		current_line = 0
		
		Global.score = (Global.distance_1 + Global.distance_2 + Global.distance_3) / 3
		print(Global.score)
		


func wait_for_lmb_release():
	while true:
		if Input.is_action_just_released(ACTION_NAME):
			return null
		await get_tree().process_frame
		
func wait_for_lmb_press():
	while true:
		if Input.is_action_just_pressed(ACTION_NAME) and current_line == 2:
			return null
		await get_tree().process_frame

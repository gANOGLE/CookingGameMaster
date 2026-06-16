extends Sprite2D
# this was all a pain ahhhhh
@onready var knife: Sprite2D = $"."
var cuts_done = 0
const KNIFE_SPEED = 7
var current_line = 1
@onready var guidline_1: Sprite2D = $"../CuttingGuidline1"
@onready var guidline_2: Sprite2D = $"../CuttingGuidline2"
@onready var guidline_3: Sprite2D = $"../CuttingGuidline3"
@onready var cut: AudioStreamPlayer2D = $Cut

const ACTION_NAME = "CUTTING_MINIGAME_DEBUG"

var time : float
const SCALE_NUM = .5
var i = 0
var squish = false

func _ready() -> void:
	guidline_1.show()
	guidline_2.show()
	guidline_3.show()

func _process(_delta: float) -> void:
	time += _delta
	knife.position.x += KNIFE_SPEED
	if knife.position.x > 480:
		if Global.score == 0:
			Global.score = 999
			guidline_1.hide()
			guidline_2.hide()
			guidline_3.hide()
	if squish == true:
		if i < 10:
			if i < 1:
				self.scale = Vector2(0.38,.475)
				self.position.y = -35
			else:
				self.scale = Vector2(.4,.5)
				self.position.y = -27
			i += 1
			get_parent().get_node("CuttingItem").scale.y = SCALE_NUM-((.2*SCALE_NUM)*_get_sine(15))
		else:
			i = 0
			get_parent().get_node("CuttingItem").scale.y = SCALE_NUM
			squish = false


func _unhandled_input(event: InputEvent) -> void:
	
	if Global.score == 0:
		if event is InputEventMouseButton: 
			if current_line == 1:
				#here
				#squish = true
				#cut.play()
				#i = 0
				_cut_item()
				
				Global.distance_1 = abs(guidline_1.position.x - knife.position.x)
				guidline_1.hide()
				current_line = 2
				

				
				while not Input.is_action_just_released("CUTTING_MINIGAME_DEBUG"):
					await get_tree().process_frame
					
				
				while not Input.is_action_pressed("CUTTING_MINIGAME_DEBUG"):
					await get_tree().process_frame
				#squish = true
				#cut.play()
				#i = 0
				_cut_item()
				Global.distance_2 = abs(guidline_2.position.x - knife.position.x)
				guidline_2.hide()
				current_line = 3
				
				while not Input.is_action_just_released("CUTTING_MINIGAME_DEBUG"):
					await get_tree().process_frame
					
				
				while not Input.is_action_pressed("CUTTING_MINIGAME_DEBUG"):
					await get_tree().process_frame
				_cut_item()
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

func _get_sine(speed):
	return sin(time*speed)*1
	
func _cut_item():
	squish = true
	cut.play()
	i = 0
	return

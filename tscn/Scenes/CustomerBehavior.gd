extends AnimatedSprite2D

#Time&Nums
var time : float
const SCALE_NUM = .345

#Gameplay vars
var phase = 0
var order = 0
var patience = 30
var calledupon = false

#Customization variables
var skincolor = 0
var face = 0
var hair = 0
var outfit = 0
var customername = ""

#Lists of faces
var skincolors= ["One","Two","Three"]
var faces = ["Face1","Face2","Face3","Face4","Face5"]
var hairs = ["Hair1","Hair2","Hair3","Hair4","Hair5"]
var outfits = ["Outfit1","Outfit2","Outfit3","Outfit4"]
var names = ["Amelia","Brianna","Cammy","Emily","Fiona","Gabriella",
			"Irene","Julie","Katie","Olivia","Payton","Riley","Aaron",
			"Barry","Carl","Eric","Frank","Gary","Ian",
			"Jack","Kai","Ollie","Paul","Ryan"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InteractBox.pressed.connect(_was_booped)
	$OrderBubble/AcknowledgeOrder.pressed.connect(_order_was_booped)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CustomerName.global_position.x = position.x-130
	time += delta
	match phase:
		0:
			$OrderBubble.visible = false
			$OrderBubble/CurrentOrderIcon.visible = false
			calledupon = false
			position = Vector2(698.0,0)
			skincolor = skincolors[randi_range(1,skincolors.size())-1]
			play(skincolor)
			face = faces[randi_range(1,faces.size())-1]
			_load_new_image($Face,"/CustomerJank/Faces/",face,".webp")
			hair = hairs[randi_range(1,hairs.size())-1]
			_load_new_image($Hair,"/CustomerJank/Hair/",hair,".webp")
			outfit = outfits[randi_range(1,outfits.size())-1]
			_load_new_image($Outfit,"/CustomerJank/Outfits/", outfit, ".webp")
			customername = names[randi_range(1,names.size())-1]
			$CustomerName.text = customername
			Global.Face = face
			Global.SkinColor = skincolor
			Global.Outfit = outfit
			Global.Hair = hair
			Global.CustomerName = customername
			phase += 1
		1:  #WaddleOver
			scale.y = SCALE_NUM-((.2*SCALE_NUM)*_get_sine(10))
			rotation = 0+.1*(2*_get_sine(10))
			position.x -= 5
			if position.x <= 20:
				scale.y = SCALE_NUM
				rotation = 0
				phase += 1
		2:
			scale.y = SCALE_NUM-((.1*SCALE_NUM)*_get_sine(10))
			rotation = 0+.05*(2*_get_sine(1))
			_wait_till_called()
		3:
			$OrderBubble.visible = true
			$OrderBubble/CurrentOrderIcon.visible = true
			order = Global.PossibleOrders.pick_random()
			_debug_print(order)
			_load_new_image($OrderBubble/CurrentOrderIcon,"/CustomerJank/PossibleOrderIcons/",order,".webp")
			phase += 1
		4:
			scale.y = SCALE_NUM-((.05*SCALE_NUM)*_get_sine(10))
			rotation = 0+.01*(2*_get_sine(1))
			_wait_till_called()
		5:
			$OrderBubble.visible = false
			$OrderBubble/CurrentOrderIcon.visible = false
			get_parent().get_node("OrderList").get_node("Order").visible = true
			scale.y = SCALE_NUM-((.05*SCALE_NUM)*_get_sine(10))
			rotation = 0+.01*(2*_get_sine(1))
			
func _load_new_image(tochange,target,specific, fileType):
	var path = "res://Assets" + target + specific + fileType
	if ResourceLoader.exists(path):
		tochange.texture = load(path)
	else:
		print("Image not found: ", path)

func _wait_till_called():
	if calledupon:
		calledupon = false
		scale.y = SCALE_NUM
		rotation = 0
		phase += 1
	
func _was_booped():
	match phase:
		2:
			calledupon = true
		_:
			print("But it's dead")
			
func _order_was_booped():
	_debug_print("Booped")
	match phase:
		4:
			calledupon = true
		_:
			print("Order? But I hardly even know 'er")

func _debug_print(text):
		print("Restraunt/CustomerBehavior: " + str(text))

func _get_sine(speed):
	return sin(time*speed)*1

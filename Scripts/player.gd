extends CharacterBody2D
var speed = 300.0
var jump_speed = -400.0
var torches = 1
var ropes = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var burnout = 0.0
var ItemSelected : int = 0
@onready var animation = get_node("AnimationPlayer")

func _physics_process(delta):
	#Gravitace
	velocity.y += gravity * delta
	#Možnost skákat
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_speed
	#Pohyb
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	#otevření inventáře
	if Input.is_action_just_pressed("ui_inventory"):
		var inv = get_node("/root/Scene/UI/Inventory")
		if(inv.visible == true):
			inv.visible = false
		else:
			inv.visible = true
	# Při idle
	if(velocity.x==0):
		animation.play("Idle")
	# Při chůzi vlevo
	if (velocity.x==-speed):
		animation.play("Walk")
		flip("left")
	#Při chůzi vpravo
	if (velocity.x==speed):
		animation.play("Walk")
		flip("right")
	move_and_slide()
	torchHandler(delta)

func torch_update(number):
	var popis = get_node("/root/Scene/UI/Inventory")
	torches += number
	popis.set_item_text(1,"Torches (" + str(torches) + ")")

func flip(direction):
	var side
	var itemOffset
	if(direction=="left"):
		side = true
		itemOffset = -15
	else:
		side = false
		itemOffset = 20
	$Sprite.flip_h = side
	$Hand.flip_h = side
	$Item.offset = Vector2(itemOffset,0)
	$Item.get_child(0).offset = Vector2(itemOffset,0)

func torchHandler(timing):
	#povolení pochodní když jsou k dispozici
	var Inventory = get_node("/root/Scene/UI/Inventory")
	if(burnout > 0 || torches > 0):
		Inventory.set_item_disabled(1,false)
	elif(torches == 0 && burnout == 0):
		Inventory.set_item_disabled(1,true)
	#pochodeň hoří když je vytažená a je odebrána když poslední dohořela
	if(ItemSelected == 1):
		if(burnout==0):
			torch_update(-1)
			burnout=3
		var burning = get_node("/root/Scene/UI/BurnOfTorch")
		burnout = burnout - 1 * timing
		burning.value = burnout
		if(burnout<0):
			Inventory.select(0)
			Inventory._on_item_selected(0)
			burnout = 0

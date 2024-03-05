extends CharacterBody2D
var speed = 300.0
var jump_speed = -400.0
var torches = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var burnout = 60.0
@export var ItemSelected : int = 0
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
	torchBurning(delta)

func torch_update(number):
	torches += number
	$Label.text = "Torches: " + str(torches)

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

func torchBurning(timing):
	if(ItemSelected == 1):
		var burning = get_node("BurnOfTorch")
		burnout = burnout - 1 * timing
		burning.value = burnout

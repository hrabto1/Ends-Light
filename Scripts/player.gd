extends CharacterBody2D
var speed = 300.0
var jump_speed = -400.0
var torches = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
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
		flip_left()
	#Při chůzi vpravo
	if (velocity.x==speed):
		animation.play("Walk")
		flip_right()
	move_and_slide()

func torch_update():
	torches += 1
	$Label.text = "Torches: " + str(torches)

func flip_left():
	$Sprite.flip_h = true
	$Hand.flip_h = true
	$Item.offset = Vector2(-15,0)

func flip_right():
	$Sprite.flip_h = false
	$Hand.flip_h = false
	$Item.offset = Vector2(20,0)

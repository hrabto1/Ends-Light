extends Camera2D
@onready var player = get_node("/root/Scene/Player")
@onready var camera = get_node("/root/Scene/Camera")
@onready var UI = get_node("/root/Scene/UI")

func _process(_delta):
	position.x = player.position.x
	position.y = player.position.y

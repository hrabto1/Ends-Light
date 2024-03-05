extends Area2D
@onready var player = get_node("/root/Player")

func _on_body_entered(body):
	if(body.name == player.name):
		player.torch_update(1)
		queue_free()

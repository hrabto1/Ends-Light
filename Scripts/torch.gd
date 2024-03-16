extends Area2D

func _on_body_entered(body):
	var player = get_node("/root/Scene/Player")
	if(body.name == player.name):
		player.torch_update(1)
		queue_free()

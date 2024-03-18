extends Area2D
signal picked_up

func _input_event(_viewport, event, _shape_idx):
	if(event is InputEventMouseButton && event.is_pressed()):
		var inv = get_node("/root/Scene/UI/Inventory")
		if(inv.is_item_disabled(2) == false):
			inv.add_item("Rope (1)",null,false)
			inv.set_item_disabled(2, true)
			inv.set_item_icon(2, load("res://Assets/Icons/rope_icon.png"))
		else:
			var player = get_node("/root/Scene/Player")
			player.rope += 1

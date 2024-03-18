extends ItemList

func _on_item_selected(index):
	var player = get_node("/root/Scene/Player")
	player.ItemSelected = index
	var hand = get_node("/root/Scene/Player/Hand")
	var item = get_node("/root/Scene/Player/Item")
	if(index==0):
		hand.visible = false
		item.visible = false
		item.get_child(0).visible = false
	else:
		hand.visible = true
		item.visible = true
		item.get_child(0).visible = true

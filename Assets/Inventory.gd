extends ItemList

func _on_item_selected(index):
	var player = get_node("../../Player")
	player.ItemSelected = index
	var hand = get_node("../../Player/Hand")
	var item = get_node("../../Player/Item")
	if(index==0):
		hand.visible = false
		item.visible = false
	else:
		hand.visible = true
		item.visible = true

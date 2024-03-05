extends ItemList
@onready var hand = get_node("../Hand")
@onready var item = get_node("../Item")

func _on_item_selected(index):
	$"/root/Player".ItemSelected = index
	if(index==0):
		hand.visible = false
		item.visible = false
	else:
		hand.visible = true
		item.visible = true

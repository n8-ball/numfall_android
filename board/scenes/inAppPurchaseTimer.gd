extends Timer

onready var board : Node2D = $".."

func _ready():
	self.connect("timeout", self, "_checkPurchases")

func _checkPurchases():
	#while InAppStore.get_pending_event_count() > 0:
	#	var event = InAppStore.pop_pending_event()
	#	if event.type == "purchase":
	#		if event.result == "ok":
	#			if event.product_id == "continue_boost":
	#				board.continueBoosts += 1
	#			if event.product_id == "row_boost":
	#				board.rowBoosts += 2
	#			if event.product_id == "column_boost":
	#				board.colBoosts += 3
	#			if event.product_id == "swap_boost":
	#				board.swapBoosts += 4
	#			if event.product_id == "start_boost":
	#				board.startBoosts += 5
	#			show_success(event.product_id)
	#		else:
	#			show_error()
	pass

func show_error():
	pass

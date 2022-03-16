extends Timer

onready var board : Node2D = $".."
var appStore

func _ready():
	if Engine.has_singleton("InAppStore"):
		appStore = Engine.get_singleton("InAppStore")
	if self.connect("timeout", self, "_checkPurchases") != 0:
		print("Signal connection error")

func _checkPurchases():
	if is_instance_valid(appStore):
		while appStore.get_pending_event_count() > 0:
			var event = appStore.pop_pending_event()
			if event.type == "purchase":
				if event.result == "ok":
					if event.product_id == "continue.boost":
						board.continueBoosts += 1
					if event.product_id == "row.boost":
						board.rowBoosts += 2
					if event.product_id == "column.boost":
						board.colBoosts += 3
					if event.product_id == "swap.boost":
						board.swapBoosts += 4
					if event.product_id == "start.boost":
						board.startBoosts += 5
					show_success(event.product_id)
				else:
					show_error()

func show_error():
	pass

func show_success(id):
	pass

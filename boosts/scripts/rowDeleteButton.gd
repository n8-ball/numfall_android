extends TextureButton

var boostScene = load("res://boosts/scenes/rowDeleteBoost.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func displayUsage():
	pass

func _pressed():
	var board = self.get_parent().board
	var rowBoost = boostScene.instance()
	
	rowBoost.setBoard(board)
	rowBoost.setButton(self)
	board.add_child(rowBoost)

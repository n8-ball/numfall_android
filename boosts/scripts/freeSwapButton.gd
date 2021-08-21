extends TextureButton

onready var posNode : Node2D = $"posNode"
onready var animator : AnimationPlayer = $"animator"

var boostScene = load("res://boosts/scenes/freeSwapBoost.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func displayUsage():
	animator.play("displayUsage")

func _pressed():
	var board = self.get_parent().board
	var freeSwapBoost = boostScene.instance()
	
	freeSwapBoost.setBoard(board)
	freeSwapBoost.setButton(self)
	board.add_child(freeSwapBoost)

extends TextureButton

onready var posNode : Node2D = $"posNode"
onready var animator : AnimationPlayer = $"animator"

var boostScene = load("res://boosts/scenes/colDeleteBoost.tscn")

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
	var colBoost = boostScene.instance()
	
	colBoost.setBoard(board)
	colBoost.setButton(self)
	colBoost.position = posNode.global_position
	board.add_child(colBoost)

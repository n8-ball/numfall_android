extends TextureButton

onready var posNode : Node2D = $"posNode"
onready var animator : AnimationPlayer = $"animator"
onready var count : RichTextLabel = $"countCir/count"

var boostScene = load("res://boosts/scenes/freeSwapBoost.tscn")

var boostCount

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_parent().connect("newMessage", self, "_newMessage")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	boostCount = self.get_parent().board.swapBoosts
	count.bbcode_text = "[center]" + str(boostCount) + "[/center]"

func displayUsage():
	animator.play("displayUsage")
	self.get_parent().emit_signal("newMessage", "free")

func _pressed():
	var board = self.get_parent().board
	if boostCount > 0:
		var freeSwapBoost = boostScene.instance()
		
		freeSwapBoost.setBoard(board)
		freeSwapBoost.setButton(self)
		freeSwapBoost.position = posNode.global_position
		board.add_child(freeSwapBoost)

func _newMessage(new):
	if !new == "free" and animator.is_playing():
		animator.play("close")

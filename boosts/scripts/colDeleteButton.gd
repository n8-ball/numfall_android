extends TextureButton

onready var posNode : Node2D = $"posNode"
onready var animator : AnimationPlayer = $"animator"
onready var count : RichTextLabel = $"countCir/count"
onready var boostButtons : Control = $".."

var boostScene = load("res://boosts/scenes/colDeleteBoost.tscn")

var boostCount

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_parent().connect("newMessage", self, "_newMessage")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	boostCount = self.get_parent().board.colBoosts
	count.bbcode_text = "[center]" + str(boostCount) + "[/center]"

func displayUsage():
	animator.play("displayUsage")
	self.get_parent().emit_signal("newMessage", "col")

func _pressed():
	var board = self.get_parent().board
	if boostCount > 0 && self.get_parent().activated:
		var colBoost = boostScene.instance()
		
		colBoost.setBoard(board)
		colBoost.setButton(self)
		colBoost.position = posNode.global_position
		board.add_child(colBoost)
	else:
		animator.play("displayUsage")
		boostButtons.emit_signal("newMessage", "col")
	
func _newMessage(new):
	if !new == "col" and animator.is_playing():
		animator.play("close")

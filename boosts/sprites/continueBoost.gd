extends Node2D

onready var menu : CanvasLayer = $".."
onready var count : RichTextLabel = $"sprite/countCir/count"

var board

var deleteList = []

func _ready():
	pass

func _process(_delta):
	if is_instance_valid(board):
		count.bbcode_text = "[center]" + str(board.continueBoosts) + "[/center]"
	else:
		board = menu.board
	self.visible = menu.getOpen()
	self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)

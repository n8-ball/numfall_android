extends TextureButton

onready var newGameConfirm : Sprite = $".."
onready var confirm : AudioStreamPlayer2D = $"../../../confirm"
onready var deny : AudioStreamPlayer2D = $"../../../deny"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _pressed():
	confirm.playSound()
	newGameConfirm.menu.board.restartGame()
	newGameConfirm.menu.setOpen(false)
	newGameConfirm.setOpen(false)

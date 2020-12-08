extends TextureButton

onready var pieceButton : TextureButton = $"../pieceButton"
onready var backgroundButton : TextureButton = $"../backgroundButton"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getPressed():
	return pressed

func setPressed(newPressed):
	self.pressed = newPressed

func _pressed():
	pieceButton.setPressed(false)
	backgroundButton.setPressed(false)

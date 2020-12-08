extends TextureButton

onready var musicButton : TextureButton = $"../musicButton"
onready var backgroundButton : TextureButton = $"../backgroundButton"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getPressed():
	return pressed

func setPressed(newPressed):
	self.pressed = newPressed

func _pressed():
	musicButton.setPressed(false)
	backgroundButton.setPressed(false)

extends TextureButton

onready var customizeMenu : CanvasLayer = $".."
onready var pieceButton : TextureButton = $"../pieceButton"
onready var backgroundButton : TextureButton = $"../backgroundButton"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.pressed:
		self.disabled = true

func getPressed():
	return self.pressed || self.disabled

func setPressed(newPressed):
	self.pressed = newPressed
	if !newPressed:
		self.disabled = false

func _pressed():
	if not customizeMenu.unlockMenuRoot.visible:
		pieceButton.setPressed(false)
		backgroundButton.setPressed(false)
		self.get_parent().confirm.play(0)
		self.setPressed(true)

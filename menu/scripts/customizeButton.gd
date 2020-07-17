extends TextureButton

onready var menu : CanvasLayer = $".."
onready var customizeMenu : CanvasLayer = $"../../customize"

var customizeOpen = false

func _process(delta):
	if menu.getOpen():
		self.visible = true
	else:
		self.visible = false

func _pressed():
	customizeMenu.setOpen(!customizeMenu.getOpen())

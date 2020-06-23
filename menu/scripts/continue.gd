extends TextureButton

onready var menu : CanvasLayer = $".."

func _process(delta):
	if menu.getOpen():
		self.visible = true
	else:
		self.visible = false

func _pressed():
	menu.setOpen(false)

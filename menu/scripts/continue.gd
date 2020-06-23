extends TextureButton

onready var menu : CanvasLayer = $".."

func _process(delta):
	if menu.getOpen():
		self.visible = true
	else:
		self.visible = false

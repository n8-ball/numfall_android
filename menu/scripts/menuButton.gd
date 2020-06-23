extends TextureButton

onready var menu : CanvasLayer = $".."

func _pressed():
	menu.setOpen(!menu.getOpen())

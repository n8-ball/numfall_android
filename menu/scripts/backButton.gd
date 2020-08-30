extends TextureButton

onready var customizeMenu : CanvasLayer = $"../.."

func _pressed():
	customizeMenu.setOpen(false)
	customizeMenu.deny.playSound()

extends TextureButton

onready var menu : CanvasLayer = $".."
onready var customizeMenu : CanvasLayer = $"../../customize"
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

var customizeOpen = false

func _process(delta):
	if menu.getOpen():
		self.visible = true
	else:
		self.visible = false
		customizeMenu.setOpen(false)

func _pressed():
	confirm.playSound()
	customizeMenu.setOpen(true)

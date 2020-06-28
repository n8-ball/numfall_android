extends TextureButton

onready var menu : CanvasLayer = $".."

var musicOn = true

func _process(delta):
	self.visible = menu.getOpen()

func _pressed():
	musicOn = !musicOn
	menu.setMusic(musicOn)

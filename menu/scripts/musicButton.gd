extends TextureButton

onready var menu : CanvasLayer = $".."

var musicOn = true

func _process(delta):
	self.visible = menu.getOpen()

func _pressed():
	musicOn = !musicOn
	self.pressed = !musicOn
	menu.board.setMusic(musicOn)

func setMusic(newMusic):
	musicOn = newMusic
	self.pressed = !musicOn

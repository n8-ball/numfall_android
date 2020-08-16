extends TextureButton

onready var menu : CanvasLayer = $".."

var soundOn = true

func _process(delta):
	self.visible = menu.getOpen()

func _pressed():
	soundOn = !soundOn
	self.pressed = !soundOn
	menu.board.setSound(soundOn)
	
func setSound(newSound):
	soundOn = newSound
	self.pressed = !soundOn

extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

var soundOn = true

func _process(delta):
	self.visible = menu.getOpen()

func _pressed():
	soundOn = !soundOn
	self.pressed = !soundOn
	menu.board.setSound(soundOn)
	if soundOn:
		confirm.playSound()
	
func setSound(newSound):
	soundOn = newSound
	self.pressed = !soundOn

func getSound():
	return soundOn

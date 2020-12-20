extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer = $"../confirm"
onready var deny: AudioStreamPlayer = $"../deny"

var soundOn = true

func _process(delta):
	self.visible = menu.getOpen()
	self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)

func _pressed():
	soundOn = !soundOn
	self.pressed = !soundOn
	menu.board.setSound(soundOn)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), !soundOn)
	if soundOn:
		confirm.playSound()
	
func setSound(newSound):
	soundOn = newSound
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), !soundOn)
	self.pressed = !soundOn

func getSound():
	return soundOn

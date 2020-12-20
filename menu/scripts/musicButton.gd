extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer = $"../confirm"
onready var deny: AudioStreamPlayer = $"../deny"

var musicOn = true

func _process(delta):
	self.visible = menu.getOpen()
	self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)

func _pressed():
	musicOn = !musicOn
	self.pressed = !musicOn
	menu.board.setMusic(musicOn)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !musicOn)
	if musicOn:
		confirm.playSound()
	else:
		deny.playSound()

func setMusic(newMusic):
	musicOn = newMusic
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !musicOn)
	self.pressed = !musicOn

extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

var musicOn = true

func _process(delta):
	self.visible = menu.getOpen()
	self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)

func _pressed():
	musicOn = !musicOn
	self.pressed = !musicOn
	menu.board.setMusic(musicOn)
	if musicOn:
		confirm.playSound()
	else:
		deny.playSound()

func setMusic(newMusic):
	musicOn = newMusic
	self.pressed = !musicOn

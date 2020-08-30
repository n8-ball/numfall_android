extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

func _process(delta):
		self.visible = menu.getOpen()

func _pressed():
	deny.playSound()
	menu.board.restartGame()
	menu.setOpen(false)
	

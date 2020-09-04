extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

func _process(delta):
	self.visible = !menu.getOpen() && !menu.board.getTutorialStarted()

func _pressed():
	confirm.playSound()
	menu.setOpen(true)
	menu.board.cancelSave()
	menu.board.saveLoad.saveGame()
	menu.board.clearBoard()

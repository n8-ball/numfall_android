extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer = $"../confirm"
onready var deny: AudioStreamPlayer = $"../deny"

func _process(_delta):
	self.visible = !menu.getOpen() && !menu.board.getTutorialStarted()

func _pressed():
	confirm.playSound()
	menu.setOpen(true)
	menu.board.cancelSave()
	menu.board.saveLoad.saveGame()
	menu.board.clearBoard()

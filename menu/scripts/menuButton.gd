extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer = $"../confirm"
onready var deny: AudioStreamPlayer = $"../deny"

func _process(_delta):
	self.visible = !menu.getOpen() && !menu.board.tutorial.getOpen()

func _pressed():
	if !menu.board.boostActive && menu.board.swapReady && !menu.getOpen():
		confirm.playSound()
		menu.setOpen(true)
		menu.board.cancelSave()
		menu.board.saveLoad.saveGame()
		menu.board.clearBoard()
	else:
		deny.playSound()

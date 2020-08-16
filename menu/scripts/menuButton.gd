extends TextureButton

onready var menu : CanvasLayer = $".."

func _process(delta):
	self.visible = !menu.getOpen()

func _pressed():
	menu.setOpen(true)
	menu.board.cancelSave()
	menu.board.saveLoad.saveGame()
	menu.board.clearBoard()

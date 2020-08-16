extends TextureButton

onready var menu : CanvasLayer = $".."

func _ready():
	var saveFile = File.new()
	self.disabled = !saveFile.file_exists("user://numfall.save")
	saveFile.close()

func _process(delta):
	if menu.getOpen():
		if self.visible == false:
			var saveFile = File.new()
			self.disabled = !saveFile.file_exists("user://numfall.save")
			saveFile.close()
		self.visible = true
	else:
		self.visible = false

func _pressed():
	menu.board.saveLoad.loadGame()
	menu.setOpen(false)

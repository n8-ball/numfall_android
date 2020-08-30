extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

var previousOpen = false

func _ready():
	self.visible = false

func _process(delta):
	if menu.getOpen():
		if self.visible == false:
			var saveFile = File.new()
			self.disabled = (!saveFile.file_exists("user://numfall.save"))\
				|| menu.board.getGameOver()
			saveFile.close()
		self.visible = true
	else:
		self.visible = false

func _pressed():
	deny.playSound()
	menu.board.saveLoad.loadGame()
	menu.board.spawner.rangeDisplay.newRange()
	menu.setOpen(false)

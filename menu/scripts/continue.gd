extends TextureButton

onready var menu : CanvasLayer = $".."
onready var newGameConfirm : Sprite = $"../newGameButton/newGameConfirm"
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

var previousOpen = false
var enabled = false

func _ready():
	self.visible = false

func _process(delta):
	if menu.getOpen():
		if self.visible == false:
			var saveFile = File.new()
			self.disabled = ((!saveFile.file_exists("user://numfall.save"))\
				|| menu.board.getGameOver())
			enabled = !self.disabled
			if saveFile.file_exists("user://numfall.save"):
				saveFile.close()
		self.visible = true
		self.disabled = !enabled || newGameConfirm.getOpen()
		self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)
	else:
		self.visible = false

func _pressed():
	deny.playSound()
	menu.board.saveLoad.loadGame()
	menu.board.spawner.rangeDisplay.newRange()
	menu.setOpen(false)

func getEnabled():
	return enabled

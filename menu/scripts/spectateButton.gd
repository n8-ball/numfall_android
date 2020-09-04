extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

var previousOpen = false

func _ready():
	self.visible = false

func _process(delta):
	if menu.getOpen():
		self.visible = true
		self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)
	else:
		self.visible = false

func _pressed():
	deny.playSound()
	menu.board.saveLoad.loadGame()
	menu.board.spawner.rangeDisplay.newRange()
	menu.setOpen(false)

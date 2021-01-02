extends Sprite

onready var menu : CanvasLayer = $".."

func _process(_delta):
	if !menu.gameOverStart:
		self.visible = menu.open
		self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)
	else:
		self.visible = true

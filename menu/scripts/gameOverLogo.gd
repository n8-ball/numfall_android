extends Sprite

onready var menu : CanvasLayer = $".."

func _process(delta):
	if !menu.gameOverStart:
		self.visible = menu.open
		self.modulate = Color(1, 1, 1, 1)
	else:
		self.visible = true
		self.modulate = Color(1, 1, 1, menu.gameOverTimer/menu.gameOverDelay)

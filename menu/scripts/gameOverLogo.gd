extends Sprite

onready var menu : CanvasLayer = $".."
onready var highScoreText : RichTextLabel = $"highScoreIndicator"

func _process(_delta):
	highScoreText.visible = (menu.board.score >= menu.board.highScore)
	if !menu.gameOverStart:
		self.visible = menu.open
		self.modulate = Color(1, 1, 1, 1)
	else:
		self.visible = true
		self.modulate = Color(1, 1, 1, menu.gameOverTimer/menu.gameOverDelay)

extends ColorRect

onready var menu : CanvasLayer = $".."

const maxOpacity = 0.25
const opacitySpeed = 0.05
const gameOverOpacitySpeed = 0.005

func _ready():
	self.color.a = maxOpacity

func _process(delta):
	if menu.getOpen():
		if self.color.a < maxOpacity && !menu.board.getGameOver():
			self.color.a = self.color.a + opacitySpeed
		elif self.color.a < maxOpacity:
			self.color.a = self.color.a + gameOverOpacitySpeed
	else:
		if self.color.a > 0:
			self.color.a = self.color.a - opacitySpeed

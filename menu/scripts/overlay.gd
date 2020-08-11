extends ColorRect

onready var menu : CanvasLayer = $".."

const maxOpacity = 0.25
const opacitySpeed = 0.05

func _process(delta):
	if menu.getOpen():
		if self.color.a < maxOpacity:
			self.color.a = self.color.a + opacitySpeed
	else:
		if self.color.a > 0:
			self.color.a = self.color.a - opacitySpeed

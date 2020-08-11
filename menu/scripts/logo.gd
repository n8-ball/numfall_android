extends Sprite

onready var menu : CanvasLayer = $".."


func _process(delta):
	self.visible = menu.open

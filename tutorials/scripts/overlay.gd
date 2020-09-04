extends ColorRect

onready var tutorial : CanvasLayer = $".."

var start = Vector2(150, 400)
var end = Vector2(500, 200)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.visible = tutorial.getOpen()

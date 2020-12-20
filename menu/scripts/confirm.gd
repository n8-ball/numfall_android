extends AudioStreamPlayer

onready var soundButton : TextureButton = $"../soundButton"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playSound():
	self.play(0)

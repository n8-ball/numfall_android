extends AudioStreamPlayer

onready var board : Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !playing:
		play(0)
		autoplay = true

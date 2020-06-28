extends AudioStreamPlayer2D

onready var board : Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if board.getMusic():
		if !playing:
			play(0)
		autoplay = true
	else:
		autoplay = false
		playing = false

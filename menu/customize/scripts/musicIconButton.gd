extends TextureButton

#External
onready var customizeMusic : Container = $".."

#Internal
onready var previewMusic : AudioStreamPlayer = $"previewMusic"

var previewed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !self.pressed:
		previewMusic.stop()

func unselect():
	self.pressed = false

func _pressed():
	if self.pressed && !previewMusic.playing:
		previewMusic.play(0)
	else:
		previewMusic.stop()

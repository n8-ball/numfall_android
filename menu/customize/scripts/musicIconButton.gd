extends TextureButton

#External
onready var customizeMusic : Container = $".."

#Internal
onready var previewMusic : AudioStreamPlayer2D = $"previewMusic"

var previewed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	previewMusic.connect("finished", self, "_on_finished")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if customizeMusic.unlocked:
		pass
	else:
		pass
	if !self.pressed:
		previewMusic.stop()

func unselect():
	if customizeMusic.unlocked:
		self.pressed = false

func _pressed():
	if self.pressed && !previewMusic.playing:
		previewMusic.play(0)
	else:
		previewMusic.stop()

func _on_finished():
	self.pressed = false
	customizeMusic.subMenuRoot.restartMusic()

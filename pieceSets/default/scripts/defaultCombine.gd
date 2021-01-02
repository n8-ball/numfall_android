extends AudioStreamPlayer2D

const defaultPitch = 1
const pitchDelay = 1
var pitchTimer = 0
var pitchAdd = 0.1
var tracking = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tracking:
		pitchTimer += delta
	if pitchTimer > pitchDelay:
		tracking = false
		self.pitch_scale = defaultPitch
		pitchTimer = 0

func playScaled(playTime, stacks):
	self.pitch_scale = defaultPitch + (pitchAdd * (stacks - 1))
	play(playTime)
	tracking = true
	pitchTimer = 0

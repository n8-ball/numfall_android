extends Node2D

var fadingOut = false
var fadingIn = false
var fadeSpeed = 3
signal doneFading

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fadingOut == true:
		fadeOut(delta)
	if fadingIn == true:
		fadeIn(delta)

func fadeOut(delta = 0):
	fadingOut = true
	fadingIn = false
	self.modulate.v -= fadeSpeed * delta
	if self.modulate.v <= 0.3:
		emit_signal("doneFading")
		self.queue_free()

func fadeIn(delta = 0):
	fadingIn = true
	self.modulate.v += fadeSpeed * delta
	if self.modulate.v >= 0.95:
		self.modulate = Color.white
		fadingIn = false

extends Node2D

const numCircles = 3

var fadingOut = false
var fadingIn = false
var fadeSpeed = 3
signal doneFading

onready var cirName = load("res://backgrounds/default/scenes/cirle.tscn")

var cirArray = []
var colorArray = [\
	Color(.80, .50, .2, 0.6),\
	Color(.75, .75, .75, 0.8),\
	Color(.83, .69, .22, 0.6)\
]

var posArray = [\
	Vector2(200, 600),\
	Vector2(800, 1800),\
	Vector2(900, 1000)\
]
var dirArray = [\
	Vector2(4, 3),\
	Vector2(-4, 1),\
	Vector2(3, -3)\
]
var scaleArray = [
	Vector2(4.0, 4.0),\
	Vector2(3.5, 3.5),\
	Vector2(3.0, 3.0)\
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(numCircles):
		var newCir = cirName.instance()
		add_child(newCir)
		newCir.setPos(posArray[i])
		newCir.setDir(dirArray[i])
		newCir.setCol(colorArray[i])
		newCir.setScale(scaleArray[i])
		cirArray.append(newCir)
	for j in range(numCircles):
		cirArray[j].setCircles(cirArray)

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

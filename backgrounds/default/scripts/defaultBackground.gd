extends Node2D

const numCircles = 0

var fadingOut = false
var fadingIn = false
var fadeSpeed = 3
signal doneFading

onready var cirName = load("res://backgrounds/default/scenes/cirle.tscn")

var cirArray = []
var colorArray = [\
	Color(.57, .89, .96, 0.9),\
	Color(.58, .57, .95, 0.9),\
	Color(.93, .81, .70, 0.9),\
	Color(.84, .34, .46, 0.9),\
	Color(.88, .69, .96, 0.9)\
]

var posArray = [\
	Vector2(400, 400),\
	Vector2(1220, 350),\
	Vector2(700, 1000),\
	Vector2(250, 2400),\
	Vector2(1200, 2350)\
]
var dirArray = [\
	Vector2(4, 3),\
	Vector2(-4, 1),\
	Vector2(3, -3),\
	Vector2(2, -1),\
	Vector2(-2, 1)\
]
var scaleArray = [
	Vector2(8.0, 8.0),\
	Vector2(6.0, 6.0),\
	Vector2(2.5, 2.5),\
	Vector2(3.5, 3.5),\
	Vector2(2.0, 2.0)\
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

extends Node2D

var circleScene = load("res://backgrounds/juicy/scenes/circle.tscn")
onready var circleLayer : Node2D = $circleLayer

var fadingOut = false
var fadingIn = false
var fadeSpeed = 3
signal doneFading

var colorList = [
	Color("D171FF"), #Light Purple
	Color("1ED5B5"), #Teal
	Color("0B01F5"), #Blue
	Color("9D26CC"), #Purple
	Color("30B5C9"), #Murky Teal
]

var positionList = [
	Vector2(1400, 40),
	Vector2(40, 1300),
	Vector2(1400, 2520),
	Vector2(40, 2520),
	Vector2(1400, 1400),
]

var scaleList = [
	12,
	7,
	9,
	8,
	6,
]

var dirList = [
	Vector2(4, -3),
	Vector2(-3, -2),
	Vector2(-3, 2),
	Vector2(2, -1),
	Vector2(1, 2),
]

var cirList = []

func _ready():
	for i in range(len(colorList)):
		var newCircle = circleScene.instance()
		newCircle.setCol(colorList[i])
		newCircle.setPos(positionList[i])
		newCircle.setScale(Vector2(scaleList[i], scaleList[i]))
		newCircle.setDir(dirList[i])
		circleLayer.add_child(newCircle)
		cirList.append(newCircle)
	for j in range(len(colorList)):
		cirList[j].setCircles(cirList)


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

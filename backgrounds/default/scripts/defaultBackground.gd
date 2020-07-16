extends Node2D

const numCircles = 3

onready var cirName = load("res://backgrounds/default/scenes/cirle.tscn")

var cirArray = []
var colorArray = [\
	Color(.96, .55, 1, 0.6),\
	Color(.7, .84, 1, 0.8),\
	Color(.79, .28, .96, 0.6)\
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
#func _process(delta):
#	pass

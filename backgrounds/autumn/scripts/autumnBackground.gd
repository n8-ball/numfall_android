extends Node2D

const numCircles = 3

onready var cirName = load("res://backgrounds/default/scenes/cirle.tscn")

var cirArray = []
var colorArray = [
	Color(.65, .30, .30, 0.7), #Maroon
	Color(.90, .45, .40, 0.7), #Red
	Color(1.0, .76, .40, 0.8)  #Orange
]
var posArray = [
	Vector2(200, 600),
	Vector2(800, 1800),
	Vector2(900, 1000)
]
var dirArray = [
	Vector2(4, 3),
	Vector2(-4, 1),
	Vector2(3, -3)
]
var scaleArray = [
	Vector2(3.4, 3.4),
	Vector2(3.7, 3.7),
	Vector2(3.0, 3.0)
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

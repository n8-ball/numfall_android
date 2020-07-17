extends Button

onready var customize : Node2D = $"../../../../.."

var tileSet = "res://pieceSets/pixel/scenes/pixel.tscn"

func _pressed():
	customize.changeTileSet(tileSet)

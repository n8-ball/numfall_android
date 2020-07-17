extends Button

onready var customize : Node2D = $"../../../../.."

var tileSet = "res://pieceSets/default/scenes/default.tscn"

func _pressed():
	customize.changeTileSet(tileSet)

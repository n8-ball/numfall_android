extends Button

onready var customize : CanvasLayer = $"../../../../.."

var tileSet = "res://pieceSets/default/scenes/default.tscn"

func _pressed():
	customize.changeTileSet(tileSet)

extends Button

onready var customize : Node2D = $"../../../../.."

var tileSet = "res://pieceSets/neon/scenes/neon.tscn"

func _process(delta):
	if customize.achievementDict != null:
		self.disabled = !customize.achievementDict["pixelTile"]

func _pressed():
	customize.changeTileSet(tileSet)

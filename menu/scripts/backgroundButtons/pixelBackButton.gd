extends Button

onready var customize : CanvasLayer = $"../../../../.."

var background = load("res://backgrounds/pixel/scenes/pixelBackground.tscn")

func _pressed():
	customize.changeBackground(background)

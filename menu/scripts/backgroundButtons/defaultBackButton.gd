extends Button

onready var customize : CanvasLayer = $"../../../../.."

var background = load("res://backgrounds/default/scenes/defaultBackground.tscn")

func _pressed():
	customize.changeBackground(background)

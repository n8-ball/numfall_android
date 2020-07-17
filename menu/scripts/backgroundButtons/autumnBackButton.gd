extends Button

onready var customize : Node2D = $"../../../../.."

var background = load("res://backgrounds/autumn/scenes/autumnBackground.tscn")

func _pressed():
	customize.changeBackground(background)

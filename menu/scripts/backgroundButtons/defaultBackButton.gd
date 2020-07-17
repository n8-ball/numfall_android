extends Button

onready var customize : Node2D = $"../../../../.."

var background = load("res://backgrounds/default/scenes/defaultBackground.tscn")

func _pressed():
	customize.changeBackground(background)

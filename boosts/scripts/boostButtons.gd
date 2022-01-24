extends Control

onready var board : Node2D = $".."

signal newMessage

var activated = true

func _process(_delta):
	activated = !board.getGameOver()

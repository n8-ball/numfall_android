extends Node2D

onready var backgroundButton : TextureButton = $".."
onready var backgroundList : GridContainer = $"backgroundList"
onready var customize : CanvasLayer = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.visible = backgroundButton.getPressed()

func changeResource(newResourceName, newBackgroundName):
	customize.changeBackground(newResourceName, newBackgroundName)

func setBackground(backgroundName):
	backgroundList.setItem(backgroundName)

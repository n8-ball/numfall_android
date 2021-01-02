extends Node2D

#External
onready var customizeItem : Container = $".."

#Internal
onready var selectButton : TextureButton = $"selectButton"
onready var unlockButton : TextureButton = $"unlockButton"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if customizeItem.unlocked:
		selectButton.disabled = false
		selectButton.visible = true
		unlockButton.disabled = true
		unlockButton.visible = false
		if selectButton.pressed:
			selectButton.disabled = true
	else:
		selectButton.disabled = true
		selectButton.visible = false
		unlockButton.disabled = false
		unlockButton.visible = true
	if !selectButton.pressed:
		selectButton.disabled = false

func unselect():
	if customizeItem.unlocked:
		selectButton.pressed = false

func select():
	selectButton.pressed = true

extends TextureButton

onready var tutorialConfirm : Sprite = $".."
onready var confirm : AudioStreamPlayer = $"../../../confirm"
onready var deny : AudioStreamPlayer = $"../../../deny"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _pressed():
	deny.playSound()
	tutorialConfirm.setOpen(false)

extends TextureButton

onready var customizeMenu : CanvasLayer = $".."
onready var menuAnimator : AnimationPlayer = $"../../menuAnimator"

func _pressed():
	menuAnimator.play("customizeToMenu")
	customizeMenu.deny.playSound()
	customizeMenu.restartMusic()

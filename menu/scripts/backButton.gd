extends TextureButton

onready var customizeMenu : CanvasLayer = $".."
onready var menuAnimator : AnimationPlayer = $"../../menuAnimator"

func _pressed():
	if not customizeMenu.unlockMenuRoot.visible:
		menuAnimator.play("customizeToMenu")
		customizeMenu.deny.playSound()
		customizeMenu.restartMusic()

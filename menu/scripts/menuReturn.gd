extends TextureButton

onready var menuAnimator : AnimationPlayer = $"../../../menuAnimator"
onready var deny : AudioStreamPlayer = $deny

func _pressed():
	menuAnimator.play("creditsToMenu")
	deny.play()

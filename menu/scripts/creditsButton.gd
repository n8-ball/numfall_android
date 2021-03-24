extends Button

onready var menuAnimator : AnimationPlayer = $"../menuAnimator"

onready var menu : CanvasLayer = $".."
onready var confirm: AudioStreamPlayer = $"../confirm"
onready var deny: AudioStreamPlayer = $"../deny"

func _process(_delta):
	self.visible = menu.getOpen()
	self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)

func _pressed():
	menuAnimator.play("dropToCredits")
	confirm.play()

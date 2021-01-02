extends TextureButton

onready var menu : CanvasLayer = $".."
onready var newGameConfirm : Sprite = $"../newGameButton/newGameConfirm"
onready var menuAnimator : AnimationPlayer = $"../menuAnimator"
onready var confirm: AudioStreamPlayer = $"../confirm"
onready var deny: AudioStreamPlayer = $"../deny"

var customizeOpen = false

func _process(_delta):
	if menu.getOpen():
		self.visible = true
		self.disabled = newGameConfirm.getOpen()
		self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)
	else:
		self.visible = false

func _pressed():
	confirm.playSound()
	menuAnimator.play("toCustomize")

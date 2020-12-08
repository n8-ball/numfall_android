extends TextureButton

onready var menu : CanvasLayer = $".."
onready var newGameConfirm : Sprite = $"../newGameButton/newGameConfirm"
onready var menuAnimator : AnimationPlayer = $"../menuAnimator"
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

var customizeOpen = false

func _process(delta):
	if menu.getOpen():
		self.visible = true
		self.disabled = newGameConfirm.getOpen()
		self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)
	else:
		self.visible = false

func _pressed():
	confirm.playSound()
	menuAnimator.play("toCustomize")

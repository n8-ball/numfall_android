extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm : AudioStreamPlayer = $"../confirm"
onready var deny : AudioStreamPlayer = $"../deny"
onready var newGameConfirm : Sprite = $"newGameConfirm"
onready var continueButton : TextureButton = $"../continueButton"

func _process(delta):
	self.visible = menu.getOpen()
	self.disabled = newGameConfirm.getOpen()
	self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)

func _pressed():
	confirm.playSound()
	if continueButton.getEnabled():
		newGameConfirm.setOpen(true)
	else:
		newGameConfirm.menu.board.restartGame()
		newGameConfirm.menu.setOpen(false)

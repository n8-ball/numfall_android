extends TextureButton

onready var menu : CanvasLayer = $".."
onready var tutorialConfirm : Sprite = $tutorialConfirm
onready var confirm: AudioStreamPlayer2D = $"../confirm"
onready var deny: AudioStreamPlayer2D = $"../deny"

var tutorialOn = true

func _process(delta):
	self.visible = menu.getOpen()
	self.modulate.a = menu.overlay.color.a * (1/menu.overlay.maxOpacity)

func _pressed():
	setTutorial(!tutorialOn)
	self.pressed = !tutorialOn
	menu.board.setTutorial(tutorialOn)
	if tutorialOn:
		confirm.playSound()
	else:
		deny.playSound()
	
func setTutorial(newTutorial):
	tutorialConfirm.setOpen(newTutorial)
	tutorialOn = newTutorial
	self.pressed = !tutorialOn

func getTutorial():
	return tutorialOn

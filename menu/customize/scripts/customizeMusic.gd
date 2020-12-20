extends Container

#External
onready var subMenuList : GridContainer = $".."
onready var subMenuRoot : Node2D = $"../.."
onready var confirm: AudioStreamPlayer = $"confirm"
onready var deny: AudioStreamPlayer = $"deny"

#Internal
onready var iconButton : TextureButton = $"iconButton"
onready var buttonControl : Node2D = $"buttonControl"
onready var itemName : RichTextLabel = $"itemName"

var unlocked = false

#Unique
var newResourceName = "res://debug/sounds/Original Tetris theme (Tetris Soundtrack).wav"
var achievementName = "default"
var displayName = "Default"

#Icon must also be changed

func _ready():
	pass # Replace with function body.
	buttonControl.selectButton.connect("pressed", self, "_on_button_select")
	iconButton.connect("pressed", self, "_on_iconButton_pressed")
	itemName.bbcode_text = "[center]" + displayName + "[/center]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Unlocked
	if achievementName == "default":
		unlocked = true
	elif subMenuRoot.customize.achievementDict != null:
		unlocked = subMenuRoot.customize.achievementDict[achievementName]
	#Icon
	if unlocked:
		iconButton.modulate = Color.white
		itemName.modulate = Color(0.43, 0.42, 0.67)
	else:
		iconButton.modulate = Color.darkgray
		itemName.modulate = Color.darkgray

func _on_button_select():
	subMenuList.unselectButtons(self)
	confirm.play()
	subMenuRoot.changeResource(newResourceName, achievementName)

func _on_iconButton_pressed():
	subMenuList.unselectPreviews(self)
	if iconButton.pressed:
		subMenuRoot.muteMusic()
	else:
		subMenuRoot.restartMusic()

func unselectButton():
	buttonControl.unselect()

func unselectPreview():
	iconButton.unselect()

func getName():
	return achievementName

func setItem():
	buttonControl.select()
	subMenuList.unselectButtons(self)
	subMenuRoot.changeResource(newResourceName, achievementName)

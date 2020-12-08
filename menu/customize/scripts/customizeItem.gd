extends CenterContainer

#External
onready var subMenuList : GridContainer = $".."
onready var subMenuRoot : Node2D = $"../.."
#onready var confirm: AudioStreamPlayer2D = $"../confirm"
#onready var deny: AudioStreamPlayer2D = $"../deny"

#Internal
onready var icon : Sprite = $"icon"
onready var buttonControl : Node2D = $"buttonControl"

var unlocked = false

#Unique
var newResourceName = "res://pieceSets/default/scenes/default.tscn"
var achievementName = "default"

#Icon must also be changed

func _ready():
	pass # Replace with function body.
	buttonControl.selectButton.connect("pressed", self, "_on_button_select")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Unlocked
	if achievementName == "default":
		unlocked = true
	elif subMenuRoot.customize.achievementDict != null:
		unlocked = subMenuRoot.customize.achievementDict[achievementName]
	#Icon
	if unlocked:
		icon.modulate = Color.white
	else:
		icon.modulate = Color.darkgray

func _on_button_select():
	subMenuList.unselectButtons(self)
	subMenuRoot.changeResource(newResourceName, achievementName)

func unselectButton():
	buttonControl.unselect()

func getName():
	return achievementName

func setItem():
	buttonControl.select()
	subMenuList.unselectButtons(self)
	subMenuRoot.changeResource(newResourceName, achievementName)

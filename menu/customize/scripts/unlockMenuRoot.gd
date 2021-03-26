extends Node2D

onready var unlockMenu : TextureButton = $"unlockMenu"
onready var unlockText : RichTextLabel = $"unlockMenu/unlockText"
onready var purchaseButton : TextureButton = $"unlockMenu/purchaseButton"
onready var unlockAnimator : AnimationPlayer = $"unlockAnimator"
onready var customize : CanvasLayer = $".."

var open = false
var achieveName = "default"

# Called when the node enters the scene tree for the first time.
func _ready():
	unlockMenu.connect("pressed", self, "_on_menu_pressed")
	purchaseButton.connect("pressed", self, "_on_purchase_pressed")

func _process(_delta):
	pass

#Headspace is 220 for 1 line, 130 for 2 lines, 50 for 3
func openUnlock(newText, newHeadSpace, newAchieveName):
	unlockText.bbcode_text = "[center]" + newText + "[/center]"
	unlockText.margin_top = newHeadSpace
	achieveName = newAchieveName
	unlockAnimator.play("open")

func _on_menu_pressed():
	unlockAnimator.play("close")

func _on_purchase_pressed():
	if achieveName != "default":
		customize.purchaseManager.purchaseItem(achieveName)
	unlockAnimator.play("close")
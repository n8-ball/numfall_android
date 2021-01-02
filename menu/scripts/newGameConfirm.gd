extends Sprite

onready var confirmAnimation : AnimationPlayer = $confirmAnimation
onready var menu : CanvasLayer = $"../.."

var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	pass

func setOpen(newOpen):
	open = newOpen
	if open:
		confirmAnimation.play("open")
	if !open:
		confirmAnimation.play("close")

func getOpen():
	return open

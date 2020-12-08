extends Sprite

onready var confirmAnimation : AnimationPlayer = $confirmAnimation

var open = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass

func setOpen(newOpen):
	if newOpen && !open:
		confirmAnimation.play("open")
	if !newOpen && open:
		confirmAnimation.play("close")
	open = newOpen

func getOpen():
	return open

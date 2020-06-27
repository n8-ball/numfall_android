extends AnimationPlayer

onready var piece : Node2D = $"../../../.."
onready var select : Sprite = $".."

func _ready():
	pass

func runAnimation():
	if piece.selState == piece.UNSELECTED:
		set_current_animation("unselected")
	
	if piece.selState == piece.SOLO_SELECTED:
		set_current_animation("solo")

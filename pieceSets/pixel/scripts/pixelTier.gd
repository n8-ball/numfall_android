extends AnimationPlayer

onready var piece : Node2D = $"../../../.."
onready var tier : Sprite = $".."

var curTier = 0
const maxTier = 5
const maxPiece = 26

func _process(delta):
	updateTier()
	animateTier()

func updateTier():
	if (piece.value < (maxPiece - 1)):
		curTier = 0

	elif (piece.value >= maxPiece):
		curTier = int((floor((piece.value - 1) / maxPiece)))
	
	curTier = curTier % maxTier

func animateTier():
	if curTier == 0:
		set_current_animation("0")
	
	if curTier == 1:
		set_current_animation("1")
	
	if curTier == 2:
		set_current_animation("2")
	
	if curTier == 3:
		set_current_animation("3")
	
	if curTier == 4:
		set_current_animation("4")

extends AnimationPlayer

onready var piece : Node2D = $"../../.."
onready var block : Sprite = $".."

const maxPiece = 26

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateValue()

func updateValue():
	block.frame = int(piece.value - 1) % maxPiece

func runAnimation():
	if piece.state == piece.IDLE_STATE:
		set_current_animation("idle")
	
	if piece.state == piece.FALL_STATE:
		set_current_animation("falling")
	
	if piece.state == piece.LAND_STATE:
		set_current_animation("land")
	
	if piece.state == piece.SPAWN_STATE:
		set_current_animation("spawn")
	
	if piece.state == piece.COMBINE_TOP_STATE:
		set_current_animation("combineTop")
	
	if piece.state == piece.COMBINE_BOT_STATE:
		set_current_animation("combineBot")
	
	if piece.state == piece.INCREMENT_STATE:
		set_current_animation("increment")

	if piece.state == piece.SWITCH_LEFT_STATE:
		set_current_animation("switchLeft")
	
	if piece.state == piece.SWITCH_RIGHT_STATE:
		set_current_animation("switchRight")
	
	if piece.state == piece.DELETE_STATE:
		play_backwards("spawn")
	

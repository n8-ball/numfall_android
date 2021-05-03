extends AnimationPlayer

onready var piece : Node2D = $"../../.."
onready var block : Sprite = $".."
onready var tens : Sprite = $"../tens"
onready var ones : Sprite = $"../ones"

const maxPiece = 99
var idealOnes = 0
var idealTens = 0

var droppingToZero = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	updateValue()

func updateValue():
	idealTens = int(floor(piece.value / 10))
	idealOnes = int(piece.value) % 10
	if tens.frame > idealTens:
		tens.frame = idealTens
	if ones.frame > idealOnes:
		ones.frame = idealOnes

func forceCorrectValue():
	tens.frame = idealTens
	ones.frame = idealOnes

func forceZeroValue():
	tens.frame = 0
	ones.frame = 0

func runAnimation():
	if piece.state == piece.IDLE_STATE:
		forceCorrectValue()
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

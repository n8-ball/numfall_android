extends AnimationPlayer

onready var piece : Node2D = $"../../.."
onready var block : Sprite = $".."
onready var innerGems : Node2D = $"../innerGems"
onready var outerGems : Node2D = $"../outerGems"

const maxPiece = 40
var lastState = 0

var colorList = [
	Color("ffffff"), #White
	Color("1414ff"), #Blue
	Color("00ffd2"), #Green-Teal
	Color("14ff00"), #Emerald
	Color("ffff00"), #Yellow
	Color("ffa000"), #Orange
	Color("ff1414"), #Red
	Color("a000ff"), #Purple
	Color("ffaad2"), #Pink
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	updateValue()

func updateValue():
	var curColorIndex = int((piece.value - 1) / 5) % len(colorList)
	block.self_modulate = colorList[curColorIndex]
	
	showInnerGems(curColorIndex, piece.value)
	showOuterGems(curColorIndex, piece.value)

func showInnerGems(index, value):
	innerGems.modulate = colorList[index]
	
	var modulo = int(value - 1) % 5
	for i in range(4):
		innerGems.get_child(i).visible = i >= modulo 
	

func showOuterGems(index, value):
	var modulo = int(value - 1) % 5
	for i in range(4):
		outerGems.get_child(i).visible = i < modulo
		outerGems.get_child(i).modulate = colorList[int(index + 1 + i) % len(colorList)] 

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
	
	lastState = piece.state

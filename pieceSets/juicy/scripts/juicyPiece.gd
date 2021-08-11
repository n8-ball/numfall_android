extends Node2D

onready var blockAnimation : AnimationPlayer = $scalar/block/blockAnimation
onready var selectAnimation : AnimationPlayer = $scalar/block/select/selectAnimation
var multiplier = load("res://pieceSets/default/scenes/defaultMultiplierParticle.tscn")

onready var combineSound : AudioStreamPlayer = $combine
onready var landSound : AudioStreamPlayer = $land
onready var swapSound : AudioStreamPlayer = $swap

#State
const IDLE_STATE = 0
const FALL_STATE = 1
const LAND_STATE = 2
const SPAWN_STATE = 3
const COMBINE_TOP_STATE = 4
const COMBINE_BOT_STATE = 5
const INCREMENT_STATE = 6
const SWITCH_LEFT_STATE = 7
const SWITCH_RIGHT_STATE = 8
const DELETE_STATE = 9
var state = SPAWN_STATE

#Selection
const UNSELECTED = 0
const SOLO_SELECTED = 1
const LEFT_SELECTED = 2
const RIGHT_SELECTED = 3
var selState = UNSELECTED

var value = 1
var desPos = Vector2()

var stacks = 0
const stackDelay = 2
var stackTimer = 0

var board

# Called when the node enters the scene tree for the first time.
func _ready():
	blockAnimation.connect("animation_finished", self, "_animationEnd")
	blockAnimation.updateValue()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state == IDLE_STATE:
		if stacks != 0:
			stackTimer += 1
		if stackTimer >= stackDelay:
			stackTimer = 0
			stacks = 0

func isReady():
	return state == IDLE_STATE || state == FALL_STATE

func comparePiece(cmpPiece):
	if is_instance_valid(cmpPiece) == false:
		return -1
	if cmpPiece.getValue() == value:
		return 0
	return 1

func setPos(newPos):
	position = newPos

#Value
func setValue(newVal):
	value = newVal

func getValue():
	return value

#State
func setState(newState):
	if state != IDLE_STATE or newState != IDLE_STATE:
		state = newState
		blockAnimation.runAnimation()

		if newState == COMBINE_TOP_STATE && board != null:
			stacks += 1
			#Juicy Achievements
			if stacks == 5:
				board.achievements.getJuicyBg()
			if stacks == 7:
				board.achievements.getJuicyMusic()
			if stacks == 9:
				board.achievements.getJuicyTile()
			stackTimer = 0
			combineSound.playScaled(0, stacks)
			
			var newMultiplier = multiplier.instance()
			board.add_child(newMultiplier)
			newMultiplier.position = self.global_position
			newMultiplier.setMultiplier(stacks)
			
		if newState == LAND_STATE && board != null:
			landSound.play(0)

		#if (newState == SWITCH_LEFT_STATE || newState == SWITCH_RIGHT_STATE)\
		#	&& board != null:
		#	swapSound.play(0)

func getState():
	return state

#Select
func setSelect(newState):
	selState = newState
	selectAnimation.runAnimation()

func getSelect():
	return selState

#Animation
func _animationEnd(animName):
	if animName == "combineTop":
		value += 1
		setState(INCREMENT_STATE)
	elif animName == "combineBot" || \
		(animName == "spawn" && state == DELETE_STATE):
		self.queue_free()
	elif state != IDLE_STATE:
		setState(IDLE_STATE)

func setBoard(newBoard):
	board = newBoard

func getModifiedScore():
	return int(value * (1 + (0.5 * (stacks - 1))))

extends Node2D

onready var animator : AnimationPlayer = $"animator"
onready var board : Node2D = $".."
onready var startBoost : Node2D = $"../startBoost"
var is_open = false
var appStore
onready var purchaseAnimator : AnimationPlayer = $"startBoostPopUp/yesButton/animator"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.has_singleton("InAppStore"):
		appStore = Engine.get_singleton("InAppStore")

func open():
	animator.play("open")
	is_open = true

func close():
	animator.play_backwards("open")
	is_open = false

func is_open():
	return is_open

func yes():
	if !animator.is_playing() && board.startBoosts > 0:
		close()
		startBoost()
		startBoost.animator.play("pulse")
		board.startBoosts -= 1
	elif is_instance_valid(self.get_parent()):
		if is_instance_valid(appStore):
			var result = appStore.purchase( { "product_id" : "start.boost" } )
			if result == OK:
				print("StartBoost: OK")
				purchaseAnimator.play("busy") # show the "waiting for response" animation
			else:
				print("StartBoost: " + str(result))
				purchaseAnimator.play("error")
		
		else:
			print("InAppStore Singleton does not exist")

func no():
	if !animator.is_playing():
		close()

func startBoost():
	if is_instance_valid(board):
		for x in range(board.brdWd):
			for y in range(board.brdHt):
				var curBoard = board.board[y][x]
				if is_instance_valid(curBoard):
					curBoard.setValue(curBoard.getValue() + 10)
					curBoard.setState(curBoard.INCREMENT_STATE)
					

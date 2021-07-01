extends AudioStreamPlayer

onready var ones : Sprite = $"../scalar/block/ones"
onready var tens : Sprite = $"../scalar/block/tens"

var lastOnes = 0
var lastTens = 0
var newOnes = 0
var newTens = 0

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func playIfTick():
	newOnes = ones.frame
	newTens = tens.frame
	if lastTens != newTens or lastOnes != newOnes:
		play()
	lastOnes = newOnes
	lastTens = newTens


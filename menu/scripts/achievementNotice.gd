extends CanvasLayer

onready var background : Sprite = $background
onready var achieveSprite : Sprite = $background/achieveSprite
onready var achieveName : RichTextLabel = $background/achieveName

var movingDir = 0
var movingSpeed = 800
var holdTime = 2
var holdClock = 0
const maxHeight = 2450
const startHeight = 2820

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (movingDir == -1 && background.position.y > maxHeight) || movingDir == 1:
		background.position.y += movingDir * movingSpeed * delta
	if movingDir == -1 and background.position.y <= maxHeight:
		movingDir = 0
	if movingDir == 0:
		holdClock += delta
	if holdClock > holdTime:
		movingDir = 1
	if movingDir == 1 and background.position.y >= startHeight:
		self.queue_free()

func setAchievement(newSprite, newText):
	_ready()
	achieveSprite.texture = load(newSprite)
	achieveName.bbcode_text = "[center]" + newText + "\n unlocked!" + "[/center]"
	movingDir = -1

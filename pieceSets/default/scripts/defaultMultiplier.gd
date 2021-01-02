extends Node2D

onready var text : RichTextLabel = $text
onready var animator : AnimationPlayer = $animator

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setMultiplier(stacks):
	print(stacks)
	var multiplierDisplay = 1 + (0.5 * (stacks - 1))
	if multiplierDisplay <= 1:
		text.visible = false
	else:
		text.visible = true
		text.bbcode_text = "[center]"+str(multiplierDisplay)+"x"+"[/center]"
		animator.play("flash")

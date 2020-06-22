extends RichTextLabel

onready var board : Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bbcode_text = "[center]"+str(board.score)+"[/center]"

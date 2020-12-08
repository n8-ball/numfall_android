extends RichTextLabel

onready var board : Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bbcode_text = "[center]" + "[img]res://board/sprites/crown.png[/img] " + str(board.highScore) + "[/center]"
	if board.score >= board.highScore:
		self.modulate = Color.gold
	else:
		self.modulate = Color.white

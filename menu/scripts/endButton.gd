extends TextureButton

onready var menu : CanvasLayer = $".."
onready var confirm : AudioStreamPlayer2D = $"../confirm"
onready var deny : AudioStreamPlayer2D = $"../deny"
onready var animation : AnimationPlayer = $"AnimationPlayer"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.visible = menu.getOpen()

func _pressed():
	animation.play("drop")
	confirm.playSound()

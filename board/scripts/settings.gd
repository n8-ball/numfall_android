extends TextureButton

onready var menu : Control = $menu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	menu.visible = !menu.visible

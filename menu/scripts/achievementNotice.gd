extends CanvasLayer

onready var background : Sprite = $root/background
onready var achieveSprite : Sprite = $root/achieveSprite
onready var achieveName : RichTextLabel = $root/achieveName
onready var animator : AnimationPlayer = $animator

func _ready():
	#animator.connect("animation_finished", self, "_on_animation_end")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setAchievement(newSprite, newText):
	_ready()
	achieveSprite.texture = load(newSprite)
	achieveName.bbcode_text = newText
	animator.play("getAchievement")

func _on_animation_end(_animation):
	self.queue_free()

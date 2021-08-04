extends Node2D

onready var signs : Sprite = $background/signs
onready var animationPlayer : AnimationPlayer = $background/AnimationPlayer

var neonSigns = [
	"res://backgrounds/neon/sprites/atomic.png", #Atomic
	"res://backgrounds/neon/sprites/cactus.png", #Cactus
	"res://backgrounds/neon/sprites/heart.png", #Heart
	"res://backgrounds/neon/sprites/pineapple.png", #Pineapple
	"res://backgrounds/neon/sprites/planet.png", #Planet
	"res://backgrounds/neon/sprites/sun.png", #Sun
]

var fadingOut = false
var fadingIn = false
var fadeSpeed = 3

var menuFound = false
var queueOpen = false
var queueClose = false

signal doneFading

func _ready():
	randomize()
	signs.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if menuFound == false:
		var menu = self.get_parent().find_node("menu")
		menuFound = true
		if menu != null:
			menu.connect("menuSwitch", self, "_on_menu_switch")
	if fadingOut == true:
		fadeOut(delta)
	if fadingIn == true:
		fadeIn(delta)
	if queueOpen:
		if signs.modulate.a == 0:
			signs.texture = null
			var newTexture = load(neonSigns[randi() % len(neonSigns)])
			signs.texture = newTexture
			animationPlayer.play("fadeIn")
			queueOpen = false
	if queueClose:
		if signs.modulate.a == 1:
			animationPlayer.play("fadeOut")

func fadeOut(delta = 0):
	fadingOut = true
	fadingIn = false
	self.modulate.v -= fadeSpeed * delta
	if self.modulate.v <= 0.3:
		emit_signal("doneFading")
		self.queue_free()

func fadeIn(delta = 0):
	fadingIn = true
	self.modulate.v += fadeSpeed * delta
	if self.modulate.v >= 0.95:
		self.modulate = Color.white
		fadingIn = false

func _on_menu_switch(newOpen):
	if newOpen == false:
		queueOpen = true
		queueClose = false
	if newOpen == true:
		queueClose = true
		queueOpen = false
		

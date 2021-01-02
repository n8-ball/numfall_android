extends Node2D

onready var musicButton : TextureButton = $".."
onready var musicList : GridContainer = $"musicList"
onready var customize : CanvasLayer = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.visible = musicButton.getPressed()

func changeResource(newResourceName, newBackgroundName):
	customize.changeMusic(newResourceName, newBackgroundName)

func setMusic(musicName):
	musicList.setItem(musicName)

func muteMusic():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)

func restartMusic():
	customize.restartMusic()

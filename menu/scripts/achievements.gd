extends CanvasLayer

onready var board : Node2D = $".."
var achievementNotice = preload("res://menu/scenes/achievementNotice.tscn")

var achieveDict = {
	"defaultTile" : true,
	"pixelTile" : false,
	"neonTile" : false,
	
	"defaultBg" : true,
	"autumnBg" : false,
	"metalBg" : false,
	
	"defaultMus" : true
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getAchievements():
	return achieveDict

func checkAchievements():
	checkPixelTile()
	checkNeonTile()

func loadAchieve(newAchieve):
	if newAchieve != null:
		for key in newAchieve:
			achieveDict[key] = newAchieve[key]

func saveAchieve():
	return achieveDict

#Tile set
#Have a big piece >= 3
func checkPixelTile():
	var oldState = achieveDict["pixelTile"]
	if board.bigPiece != null && board.bigPiece >= 3:
		achieveDict["pixelTile"] = true
		if oldState == false:
			var notice = achievementNotice.instance()
			notice.setAchievement("res://pieceSets/pixel/sprites/pixel0.png", \
				"Pixel Tile")
			board.add_child(notice)
	

#Have 4 ascending rows from the bottom row
func checkNeonTile():
	var oldState = achieveDict["neonTile"]
	achieveDict["neonTile"] = true
	if oldState == false:
			var notice = achievementNotice.instance()
			notice.setAchievement("res://pieceSets/neon/sprites/neon0.png", \
				"Neon Tile")
			board.add_child(notice)

extends CanvasLayer

onready var board : Node2D = $".."

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
	checkAchievements()

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
#Have a big piece >= 10
func checkPixelTile():
	if board.bigPiece != null && board.bigPiece >= 6:
		achieveDict["pixelTile"] = true

#Have 4 ascending rows from the bottom row
func checkNeonTile():
	achieveDict["neonTile"] = true

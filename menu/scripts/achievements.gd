extends CanvasLayer

onready var board : Node2D = $".."
var achievementNotice = preload("res://menu/scenes/achievementNotice.tscn")

var achieveDict = {
	"pixelTile" : true,
	"neonTile" : true,
	"juicyTile" : true,
	"tuxedoTile" : true,
	"lcdTile" : true,
	"creepyTile": true,
	"blossomTile": true,
	
	"pixelMusic" : true,
	"neonMusic" : true,
	"juicyMusic" : true,
	"tuxedoMusic" : true,
	"lcdMusic" : true,
	"creepyMusic" : true,
	"blossomMusic" : true,
	
	"pixelBg" : true,
	"neonBg" : true,
	"juicyBg" : true,
	"tuxedoBg" : true,
	"lcdBg" : true,
	"creepyBg" : true,
	"blossomBg": true,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	checkFrameAchievements()

func getAchievements():
	return achieveDict

func checkFrameAchievements():
	checkPixelMusic()

func checkStableAchievements():
	checkPixelTile()
	checkPixelBg()
	checkNeonTile()
	checkNeonMusic()
	checkNeonBg()
	checkTuxedoTile()
	checkTuxedoMusic()
	checkTuxedoBg()
	checkLCDTile()
	checkLCDMusic()
	checkLCDBg()

func loadAchieve(newAchieve):
	if newAchieve != null:
		for key in newAchieve:
			achieveDict[key] = newAchieve[key]

func saveAchieve():
	return achieveDict

#--Pixel--

#Pixel Tile
#Achieve a max piece of 10, before a reaching a score of 1000
func checkPixelTile():
	var oldState = achieveDict["pixelTile"]
	if oldState == false:
		if board.bigPiece != null && board.bigPiece >= 10 && board.score < 1000:
			achieveDict["pixelTile"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://pieceSets/pixel/sprites/pixelPreview.png", "Retro Tile\n Unlocked!")

#Pixel Music
#Achieve a score of exactly 1000
func checkPixelMusic():
	var oldState = achieveDict["pixelMusic"]
	if oldState == false:
		if board.score == 1000:
			achieveDict["pixelMusic"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://menu/customize/sprites/pixelMusicPlay.png", "Retro Music\n Unlocked!")

#Pixel Background
#Achieve a score of 1000, before getting the 8 piece
func checkPixelBg():
	var oldState = achieveDict["pixelBg"]
	if oldState == false:
		if board.bigPiece != null && board.bigPiece < 8 && board.score >= 1000:
			achieveDict["pixelBg"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://backgrounds/pixel/sprites/pixelBackgroundPreview.png", "Retro Background\n Unlocked!")

#--Neon--

#Neon Tile
#Have 3 perfectly ascending perfect rows (on the bottom)
func checkNeonTile():
	var oldState = achieveDict["neonTile"]
	if oldState == false:
		var valid = true
		#Bottom Row:
		var checkPiece = board.board[9][0]
		var startingVal = 0
		if checkPiece != null:
			startingVal = checkPiece.getValue()
		else:
			valid = false
		for x in range(6):
			checkPiece = board.board[9][x]
			if checkPiece != null:
				if checkPiece.getValue() != startingVal:
					valid = false
					break
			else:
				valid = false
				break
			
			checkPiece = board.board[8][x]
			if checkPiece != null:
				if checkPiece.getValue() != startingVal - 1:
					valid = false
					break
			else:
				valid = false
				break
			
			checkPiece = board.board[7][x]
			if checkPiece != null:
				if checkPiece.getValue() != startingVal - 2:
					valid = false
					break
			else:
				valid = false
				break
		if valid == true:
			achieveDict["neonTile"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://pieceSets/neon/sprites/neonPreview.png", "Neon Tile\n Unlocked!")

#Neon Music
#Have 3 ascending perfect rows (on the bottom)
func checkNeonMusic():
	var oldState = achieveDict["neonMusic"]
	if oldState == false:
		var valid = true
		#Bottom Row:
		var checkPiece0 = board.board[9][0]
		var checkPiece1 = board.board[8][0]
		var checkPiece2 = board.board[7][0]
		var startingVal0 = 0
		var startingVal1 = 0
		var startingVal2 = 0
		if checkPiece0 != null:
			startingVal0 = checkPiece0.getValue()
		else:
			valid = false
		if checkPiece1 != null:
			startingVal1 = checkPiece1.getValue()
		else:
			valid = false
		if checkPiece2 != null:
			startingVal2 = checkPiece2.getValue()
		else:
			valid = false
		if startingVal0 <= startingVal1 || startingVal1 <= startingVal2 || startingVal0 <= startingVal2:
			valid = false
			print(startingVal0)
			print(startingVal1)
			print(startingVal2)
		for x in range(6):
			checkPiece0 = board.board[9][x]
			if checkPiece0 != null:
				if checkPiece0.getValue() != startingVal0:
					valid = false
					break
			else:
				valid = false
				break
			
			checkPiece1 = board.board[8][x]
			if checkPiece1 != null:
				if checkPiece1.getValue() != startingVal1:
					valid = false
					break
			else:
				valid = false
				break
			
			checkPiece2 = board.board[7][x]
			if checkPiece2 != null:
				if checkPiece2.getValue() != startingVal2:
					valid = false
					break
			else:
				valid = false
				break
		if valid == true:
			achieveDict["neonMusic"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://menu/customize/sprites/neonMusicPlay.png", "Neon Music\n Unlocked!")

#Neon Background
#Have 2 descending perfect rows
func checkNeonBg():
	var oldState = achieveDict["neonBg"]
	if oldState == false:
		for y in range(9):
			for x in range(5):
				var checkPiece = board.board[9-y][x+1]
				var leftPiece = board.board[9-y][x]
				var upPiece = board.board[8-y][x+1]
				var upLeftPiece = board.board[8-y][x]
				if checkPiece == null || leftPiece == null || upPiece == null\
					|| upLeftPiece == null:
						break
				if checkPiece.getValue() != leftPiece.getValue()\
					|| upPiece.getValue() != upLeftPiece.getValue()\
					|| upPiece.getValue() <= checkPiece.getValue():
						break
				elif x == 4:
					achieveDict["neonBg"] = true
					var notice = achievementNotice.instance()
					board.add_child(notice)
					notice.setAchievement("res://backgrounds/neon/sprites/neonBackgroundPreview.png", "Neon Background\n Unlocked!")

#--Juicy--

#Juicy Tile
#Get a 5x multiplier
func getJuicyTile():
	var oldState = achieveDict["juicyTile"]
	if oldState == false:
		achieveDict["juicyTile"] = true
		var notice = achievementNotice.instance()
		board.add_child(notice)
		notice.setAchievement("res://pieceSets/juicy/sprites/juicyPreview.png", "Juicy Tile\n Unlocked!")

#Juicy Music
#Get a 4x multiplier
func getJuicyMusic():
	var oldState = achieveDict["juicyMusic"]
	if oldState == false:
		achieveDict["juicyMusic"] = true
		var notice = achievementNotice.instance()
		board.add_child(notice)
		notice.setAchievement("res://menu/customize/sprites/juicyMusicPlay.png", "Juicy Music\n Unlocked!")

#Juicy Background
#Get a 3x multiplier
func getJuicyBg():
	var oldState = achieveDict["juicyBg"]
	if oldState == false:
		achieveDict["juicyBg"] = true
		var notice = achievementNotice.instance()
		board.add_child(notice)
		notice.setAchievement("res://backgrounds/juicy/sprites/juicyPreview.png", "Juicy Background\n Unlocked!")

#--Tuxedo--

#Tuxedo Tile
#Get a 26 piece or bigger
func checkTuxedoTile():
	var oldState = achieveDict["tuxedoTile"]
	if oldState == false:
		if board.bigPiece >= 26:
			achieveDict["tuxedoTile"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://pieceSets/tuxedo/sprites/tuxedoPreview.png", "Tuxedo Tile Unlocked!")

#Tuxedo Music
#Have 2 - 26 pieces on the bottom row
func checkTuxedoMusic():
	var oldState = achieveDict["tuxedoMusic"]
	if oldState == false:
		var count = 0
		for x in range(6):
			var checkPiece = board.board[9][x]
			if checkPiece != null:
				if checkPiece.getValue() == 26:
					count += 1
		if count >= 2:
			achieveDict["tuxedoMusic"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://menu/customize/sprites/tuxedoMusicPlay.png", "Tuxedo Music\n Unlocked!")

#Tuxedo Background
#Rollover a tileset
func checkTuxedoBg():
	var oldState = achieveDict["tuxedoBg"]
	if oldState == false:
		if board.bigPiece >= 27:
			achieveDict["tuxedoBg"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://backgrounds/tuxedo/sprites/tuxedoPreview.png", "Tuxedo Background\n Unlocked!")

#--LCD--

#LCD Tile
#Get a score of 18463 or higher
func checkLCDTile():
	var oldState = achieveDict["lcdTile"]
	if oldState == false:
		if board.score >= 18463:
			achieveDict["lcdTile"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://pieceSets/lcd/sprites/lcdPreview.png", "LCD Tile\n Unlocked!")

#LCD Music
#Get a score of 15000 or higher
func checkLCDMusic():
	var oldState = achieveDict["lcdMusic"]
	if oldState == false:
		if board.score >= 15000:
			achieveDict["lcdMusic"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://menu/customize/sprites/lcdMusicPlay.png", "LCD Music\n Unlocked!")

#LCD Background
#Get a score of 10000 or higher
func checkLCDBg():
	var oldState = achieveDict["lcdBg"]
	if oldState == false:
		if board.score >= 10000:
			achieveDict["lcdBg"] = true
			var notice = achievementNotice.instance()
			board.add_child(notice)
			notice.setAchievement("res://backgrounds/lcd/sprites/lcdBackgroundPreview.png", "LCD Background\n Unlocked!")

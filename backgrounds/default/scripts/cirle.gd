extends Sprite

var dir = Vector2(0, 0)

var rng = RandomNumberGenerator.new()

const bounceVar = 0.2
const ballRepulsionForce = 50
const wallRepulsionForce = 50
const speed = 50
const xBound = [100, 1340]
const yBound = [300, 2260]

var cirArray = []

func _process(delta):
	checkDir(delta)
	self.position += dir * speed * delta

func checkDir(delta):
	#Bounce
	if position.x < xBound[0]:
		dir.x = 1
		dir.y += rng.randf_range(-bounceVar, bounceVar)
	if position.x > xBound[1]:
		dir.x = -1
		dir.y += rng.randf_range(-bounceVar, bounceVar)
	if position.y < yBound[0]:
		dir.y = 1
		dir.x += rng.randf_range(-bounceVar, bounceVar)
	if position.y > yBound[1]:
		dir.y = -1
		dir.x += rng.randf_range(-bounceVar, bounceVar)
	#Repulsion from other balls
	for testCir in cirArray:
		if testCir != self:
			var testDir = self.position - testCir.position
			var testSpeed = 1/(self.position.distance_squared_to(testCir.position))
			testSpeed = ballRepulsionForce * testSpeed
			testDir = testDir * testSpeed * delta
			dir += testDir
	#Repulsion from edges
	var leftForce = 1/pow(position.x - xBound[0], 2)
	var rightForce = 1/pow(xBound[1] - position.x, 2)
	var botForce = 1/pow(yBound[1] - position.y, 2)
	var topForce = 1/pow(position.y - yBound[0], 2)
	
	dir.x += leftForce * wallRepulsionForce * delta
	dir.x -= rightForce * wallRepulsionForce * delta
	dir.y -= botForce * wallRepulsionForce * delta
	dir.y += topForce * wallRepulsionForce * delta
	
	dir = dir.normalized()


func setPos(newPos):
	self.position = newPos

func setDir(newDir):
	self.dir = newDir

func setCol(newCol):
	self.modulate = newCol

func setScale(newScale):
	self.scale = newScale

func setCircles(newCircles):
	cirArray = newCircles

extends Node2D

onready var cir : Sprite = $cir

onready var spectrum = AudioServer.get_bus_effect_instance(0, 0)

const numBars = 50
const totalHeight = 50

const minFreq = 2000
const maxFreq = 4000
const maxDb = -20
const minDb = -50
const cirMin = 400
const cirMult = 100

var realArray = []
var idealArray = []
var realCircleMag = 0
var idealCircleMag = 0
const matchSpeed = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in range(numBars):
		realArray.append(0)
		idealArray.append(0)

func _process(delta):
	var freq = minFreq
	var interval = (maxFreq - minFreq)/numBars
	
	idealCircleMag = spectrum.get_magnitude_for_frequency_range(minFreq, maxFreq)
	idealCircleMag = linear2db(idealCircleMag.length())
	idealCircleMag = (idealCircleMag - minDb) / (maxDb - minDb)
	idealCircleMag = clamp(idealCircleMag, 0, 1)
	
	realCircleMag += (idealCircleMag - realCircleMag) * matchSpeed
	
	for i in range(numBars):
		var freqLow = float(freq - minFreq) / float(maxFreq - minFreq)
		freqLow = freqLow * freqLow * freqLow * freqLow
		freqLow = lerp(minFreq, maxFreq, freqLow)
		
		freq += interval
		
		var freqHigh = float(freq - minFreq) / float(maxFreq - minFreq)
		freqHigh = freqHigh * freqHigh * freqHigh * freqHigh
		freqHigh = lerp(minFreq, maxFreq, freqHigh)
		
		var mag =\
			spectrum.get_magnitude_for_frequency_range(freqLow, freqHigh)
		mag = linear2db(mag.length())
		mag = (mag - minDb) / (maxDb - minDb)
		mag += 0.3 * float(freq - minFreq) / float(maxFreq - minFreq)
		mag = clamp(mag, 0.01, 1.0)
		
		idealArray[i] = mag
		realArray[i] += (idealArray[i] - realArray[i]) * matchSpeed
	update()

func _draw():
	var centerPos = Vector2(0, 0)
	var cirRad = cirMin + (realCircleMag * cirMult)
	
	for i in range(numBars):
		#Left
		draw_set_transform(Vector2(0, 0), (PI * i / numBars) + PI/(2*numBars), Vector2(1,1))
		draw_line(centerPos,\
			centerPos+Vector2(0, (realArray[i] * totalHeight) + cirRad),\
			Color.white, 128.0, true)
		#Right
		draw_set_transform(Vector2(0, 0), -(PI * i / numBars) - PI/(2*numBars), Vector2(1,1))
		draw_line(centerPos,\
			centerPos+Vector2(0, (realArray[i] * totalHeight) + cirRad),\
			Color.white, 128.0, true)
	#draw_circle(centerPos, cirRad, Color.black)
	#draw_arc(centerPos, cirRad, 0, 360, 1000,\
	#	Color.black, 16.0, true)
	cir.scale = Vector2(.5 + (realCircleMag * .08), .5 + (realCircleMag * .08))

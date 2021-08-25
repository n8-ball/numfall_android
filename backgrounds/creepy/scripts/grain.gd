#goes on a ColorRect node that is the child of a CanvasLayer node
#be sure to set the bottom and right anchor to 1 so it covers the whole scene
extends Sprite

export var frame_switch_time = 0.08 #how often to randomize the film grain
var cur_time = 0

func _process(delta):
	cur_time += delta
	if cur_time > frame_switch_time:
		cur_time = 0
		material.set_shader_param("seed", (randi() % 500) + 1.0)

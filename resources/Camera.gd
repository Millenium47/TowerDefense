extends Camera2D

onready var viewport_size = get_viewport().size

var mouse_start_pos
var screen_start_position

var dragging = false
var threshold = 100
var step = 15

func _process(delta):
	var local_mouse_pos = get_local_mouse_position()
	if local_mouse_pos.x < threshold:
		position.x -= step
	elif local_mouse_pos.x > viewport_size.x - threshold:
		position.x += step

	if local_mouse_pos.y < threshold:
		position.y -= step
	elif local_mouse_pos.y > viewport_size.y - threshold:
		position.y += step

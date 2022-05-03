extends Camera2D

var mouse_start_pos
var screen_start_position
var threshold

var screen_size = OS.get_window_size()
var dragging = false

func _input(event):
	if event.is_action("drag"):
		if event.is_pressed():
			mouse_start_pos = event.position
			screen_start_position = position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position = zoom * (mouse_start_pos - event.position) + screen_start_position
	elif event is InputEventMouseMotion:
		if(get_global_mouse_position().x > position.x + screen_size.x/2 - 150):
			position.x += 20
		elif(get_global_mouse_position().x < position.x - screen_size.x/2 + 150):
			position.x -= 20
			
		if(get_global_mouse_position().y < position.y - screen_size.y/2 + 100):
			position.y -= 20
		elif(get_global_mouse_position().y > position.y + screen_size.y/2 - 100):
			position.y += 20


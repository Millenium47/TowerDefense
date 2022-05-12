extends CanvasLayer

onready var background := $Preview
var building

func set_building_preview(building_type, mouse_position):
	building = load("res://objects/buildings/" + building_type + ".tscn").instance()
	#building = load("res://objects/buildings/Tower.tscn").instance()
	building.set_name(building_type)
	building.type = building_type
	
	var control = Control.new()
	control.add_child(building, true)
	control.rect_global_position = Vector2.ZERO
	control.set_name("BuildingPreview")
	background.add_child(control, true)
	background.move_child(get_node("BuildingPreview"),0)
	
func update_building_preview(new_position, color):
	background.get_node("BuildingPreview").rect_global_position = new_position
	if background.get_node("BuildingPreview/"+building.get_name()).modulate != Color(color):
		background.get_node("BuildingPreview/"+building.get_name()).modulate = Color(color)


func _on_PausePlay_pressed():
	if get_tree().is_paused():
		get_tree().paused = false
	elif get_parent().current_wave == 0:
		get_parent().current_wave += 1
		get_parent().start_next_wave()
	else:
		get_tree().paused = true

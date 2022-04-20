extends CanvasLayer

var building

func set_building_preview(building_type, mouse_position):
	#building = load("res://objects/buildings/" + building_type + ".tscn")
	building = load("res://objects/buildings/ArrowTower.tscn").instance()
	building.set_name("DragBuilding")
	
	var control = Control.new()
	control.add_child(building, true)
	control.rect_position = mouse_position
	control.set_name("BuildingPreview")
	add_child(control, true)
	move_child(get_node("BuildingPreview"),0)
	
func update_building_preview(new_position, color):
	get_node("BuildingPreview").rect_position = new_position
	if get_node("BuildingPreview/DragBuilding").modulate != Color(color):
		get_node("BuildingPreview/DragBuilding").modulate = Color(color)

extends Node2D

onready var UI := $UI
onready var gameboard := $Gameboard
onready var grid := $Gameboard/Grid

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type

func _process(delta):
	if build_mode:
		update_tower_preview()

func _ready():
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "initiate_build_mode", [i.get_name()])
		
func initiate_build_mode(building_type):
	build_type = building_type
	build_mode = true
	UI.set_building_preview(build_type, get_global_mouse_position())
	
func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_cell = grid.world_to_map(mouse_position) #(15,2)
	#grid.map_to_world(current_cell) (128,128)

	if current_cell in gameboard.get_cells():
		UI.update_building_preview(gameboard.calculate_map_position(current_cell), "ad54ff3c")
		build_valid = true
		build_location = current_cell
	else:
		UI.update_building_preview(gameboard.calculate_map_position(current_cell), "adff4545")
		build_valid = false

func cancel_build_mode():
	pass

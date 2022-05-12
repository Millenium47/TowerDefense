extends Node2D

onready var UI := $UI
onready var gameboard := $Gameboard
onready var background := $Gameboard/YSort/Background

var map_node

var current_wave = 0
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

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode:
		verify_and_build()
		cancel_build_mode()


func initiate_build_mode(building_type):
	build_type = building_type
	build_mode = true
	UI.set_building_preview(build_type, get_global_mouse_position())
	
func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_cell = background.world_to_map(mouse_position) #(15,2)
	#grid.map_to_world(current_cell) (128,128)

	if current_cell in gameboard.get_cells():
		UI.update_building_preview(gameboard.calculate_map_position(current_cell), "ad54ff3c")
		build_valid = true
		build_location = current_cell
	else:
		UI.update_building_preview(gameboard.calculate_map_position(current_cell), "adff4545")
		build_valid = false

func cancel_build_mode():
	build_mode = false
	build_valid = false
	UI.get_node("BuildingPreview").queue_free()

func verify_and_build():
	if build_valid:
		var new_building = load("res://objects/buildings/ArrowTower.tscn").instance()
		new_building.position = gameboard.calculate_map_position(build_location)
		background.add_child(new_building, true)

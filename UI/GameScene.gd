extends Node2D

onready var UI := $UI
onready var gameboard := $Gameboard
onready var buildable := $Gameboard/YSort/Background
onready var background := $Gameboard/YSort/Background
onready var buildings := $Gameboard/YSort/Background/Buildings
onready var player := $Player

var map_node

var current_wave = 0
var build_mode = false
var build_valid = false
var build_location
var build_type
var cost := 0

func _process(_delta):
	if build_mode:
		update_tower_preview()

func _ready():
	gameboard.connect("gold_earned", self, "_add_gold")
	player.connect("gold_changed", self, "_set_cost_availability")
	# connect buildings icons with functionality
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "_initiate_build_mode", [i.get_name(), i.cost])
	
	_set_cost_availability(player.gold)

func _unhandled_input(event):
	# build events
	if event.is_action_released("ui_cancel") and build_mode:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode:
		verify_and_build()

func _set_cost_availability(gold: int) -> void:
	for btn in get_tree().get_nodes_in_group("cost_buttons"):
		if(btn.cost > gold):
			btn.disabled = true
		else:
			btn.disabled = false

## BUILDING ##
func _initiate_build_mode(building_type: String, _cost: int) -> void:
	build_type = building_type
	build_mode = true
	cost = _cost
	UI.set_building_preview(build_type)
	
func update_tower_preview() -> void:
	var mouse_position = get_global_mouse_position()
	var current_cell = background.world_to_map(mouse_position) #(15,2)
	#grid.map_to_world(current_cell) (128,128)

	if current_cell in buildable.get_used_cells_by_id(0):
		UI.update_building_preview(gameboard.calculate_map_position(current_cell), "ad54ff3c")
		build_valid = true
		build_location = current_cell
	else:
		UI.update_building_preview(gameboard.calculate_map_position(current_cell), "adff4545")
		build_valid = false

func cancel_build_mode() -> void:
	build_mode = false
	build_valid = false
	UI.get_node("Preview/BuildingPreview").queue_free()

func verify_and_build() -> void:
	if build_valid:
		var new_building = load("res://objects/buildings/" + build_type + ".tscn").instance()
		new_building.position = gameboard.calculate_map_position(build_location)
		new_building.built = true
		new_building.type = build_type
		background.set_cellv(build_location, 1)
		buildings.add_child(new_building, true)
		player.remove_gold(cost)
		cancel_build_mode()

func _add_gold(value: int) -> void:
	player.add_gold(value)

extends Node2D

onready var _tilemap := $Grid
onready var _astar_grid := $AStarGrid
onready var _enemy_path := $Path2D

export var cell_size := Vector2(64, 64)

var _current_cell := Vector2.ZERO
var _start_cell := Vector2.ZERO
var _end_cell := Vector2.ZERO
var walking_path
var enemy_curve

var start_placed = false
var end_placed = false

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("placed"):
		if !start_placed:
			_start_cell = _tilemap.world_to_map(get_global_mouse_position())
			print("start cell:", _start_cell)
			start_placed = true
		elif !end_placed:
			_end_cell = _tilemap.world_to_map(get_global_mouse_position())
			print("end cell:", _end_cell)
			end_placed = true
		
	if start_placed && end_placed && walking_path == null:
		var cells = _tilemap.get_used_cells_by_id(1)
		
		walking_path = _astar_grid.get_astar_path(cells, _start_cell, _end_cell)
		print("walking path: ",walking_path.size())
		for cell in walking_path:
			_tilemap.set_cellv(cell, 0)
			
		_tilemap.set_cellv(walking_path[0], 2)
		_tilemap.set_cellv(walking_path[walking_path.size() - 1], 2)
		
		_create_enemy_curve(walking_path)
		
func calculate_map_position(grid_position: Vector2) -> Vector2:
	return grid_position * cell_size + cell_size/2		
		
func _create_enemy_curve(path):
	enemy_curve = Curve2D.new()
	for cell in path:
		enemy_curve.add_point(calculate_map_position(cell))
	
	_enemy_path.curve = enemy_curve
	

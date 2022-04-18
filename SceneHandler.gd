extends Node2D

onready var _tilemap := $Grid
onready var _astar_grid := $AStarGrid

var _current_cell := Vector2.ZERO
var _start_cell := Vector2.ZERO
var _end_cell := Vector2.ZERO
var walking_path

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
		
		if start_placed && end_placed:
			var cells = _tilemap.get_used_cells_by_id(1)
			print(_astar_grid)
			walking_path = _astar_grid.get_astar_path(cells, _start_cell, _end_cell)
			print("walking path: ",walking_path.size())
			for cell in walking_path:
				_tilemap.set_cellv(cell, 0)
			_tilemap.set_cellv(walking_path[0], 2)
			_tilemap.set_cellv(walking_path[walking_path.size() - 1], 2)

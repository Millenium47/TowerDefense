extends Node2D

onready var _tilemap := $Grid
onready var _astar_grid := $AStarGrid
onready var _enemy_path := $Path2D

export var cell_size := Vector2(64, 64)

var enemy = preload("res://objects/Enemy.tscn")

var cells setget set_cells, get_cells

var walking_path
var enemy_curve


func _ready():
	randomize()
	set_cells(1)#_tilemap.get_used_cells_by_id(1)
	var random_start = cells[randi() % cells.size()]
	var random_end = Vector2(16,8) #test data
	
	walking_path = _astar_grid.get_astar_path(cells, random_start, random_end)
	for cell in walking_path:
		_tilemap.set_cellv(cell, 0)
			
	_tilemap.set_cellv(walking_path[0], 2)
	_tilemap.set_cellv(walking_path[walking_path.size() - 1], 2)
	
	_create_enemy_curve(walking_path)
	_spawn_enemies()

func calculate_map_position(grid_position: Vector2) -> Vector2:
	return grid_position * cell_size + cell_size/2		

func _create_enemy_curve(path):
	enemy_curve = Curve2D.new()
	for cell in path:
		enemy_curve.add_point(calculate_map_position(cell))
	
	_enemy_path.curve = enemy_curve

func _spawn_enemies():
	_enemy_path.add_child(enemy.instance(), true)

func get_cells():
	return cells

func set_cells(_id):
	cells = _tilemap.get_used_cells_by_id(_id)

extends Node2D

onready var background := $YSort/Background
onready var roads := $YSort/Background/Roads
onready var buildings := $YSort
onready var enemy_paths := $Paths
onready var astar := $YSort/AStarGrid
onready var castle = preload("res://objects/buildings/Castle.tscn").instance()
onready var enemy_camp = preload("res://objects/buildings/EnemyCamp.tscn")

enum BUILDABLE {TRUE = 0, FALSE = 1}

export var cell_size := Vector2(64, 64)

var basic_enemy = preload("res://objects/enemies/Basic.tscn").instance()
var elite = preload("res://objects/enemies/Elite.tscn").instance()
var enemies = [elite, basic_enemy]

var cells setget , get_cells

#my_group_members = get_tree().get_nodes_in_group("enemy_camps")
var enemy_camps = []

func _ready():
	self.connect("spawn_next_wave", self, "_spawn_next_wave")
	
	cells = background.get_used_cells_by_id(0)
	_spawn_castle()
	_spawn_enemy_camp(Vector2(7, 6))	
	_spawn_enemy_camp(Vector2(9, 9))
	_spawn_enemy_camp(Vector2(15, 20))	
	

	_spawn_next_wave(10, "EnemyCamp1")
	
func _spawn_next_wave(value, camp_name):
	var enemies_to_spawn = []
	
	for enemy in enemies:
		randomize()
		var num_to_spawn = randi() % (value/enemy.cost + 1)
		value -= num_to_spawn * enemy.cost
		
		for _i in range(0, num_to_spawn):
			enemies_to_spawn.append(enemy.duplicate())
			
	if value != 0:
		for leftover in value:
			enemies_to_spawn.append(basic_enemy.duplicate())
		
	_spawn_enemies(enemies_to_spawn, camp_name)	

func _spawn_enemies(enemies_to_spawn, camp_name):
	var current_path = enemy_paths.get_node(camp_name)

	for enemy in enemies_to_spawn:
		yield(get_tree().create_timer(0.75), "timeout")
		current_path.add_child(enemy)

func _spawn_castle():
	castle.cell = Vector2(30, 15)
	castle.position = calculate_map_position(castle.cell)
	buildings.add_child(castle)

func _spawn_enemy_camp(spawn_position):
	var new_enemy_camp = enemy_camp.instance()
	var new_enemy_camp_num = "EnemyCamp"+str(enemy_camps.size())
	new_enemy_camp.cell = spawn_position
	new_enemy_camp.position = calculate_map_position(new_enemy_camp.cell)
	new_enemy_camp.set_name(new_enemy_camp_num)
	buildings.add_child(new_enemy_camp)
	
	_create_road_to_castle(new_enemy_camp)
	
	enemy_camps.append(new_enemy_camp)

func _create_road_to_castle(new_enemy_camp):
	var path_to_castle = astar.get_astar_path(cells, roads.get_used_cells_by_id(0), new_enemy_camp.cell, castle.cell)

	for cell in path_to_castle:
		background.set_cellv(cell, BUILDABLE.FALSE)
		roads.set_cellv(cell, 0)
		roads.update_bitmask_area(cell)
		
	#remove autotiling overlay on buildings
	roads.set_cellv(path_to_castle[0], -1)
	roads.set_cellv(path_to_castle[path_to_castle.size()-1], -1)
	
	var new_enemy_path = Path2D.new()
	new_enemy_path.curve = _create_enemy_curve(path_to_castle)
	new_enemy_path.set_name(new_enemy_camp.get_name())
	enemy_paths.add_child(new_enemy_path)

func _create_enemy_curve(path) -> Curve2D:
	var enemy_curve = Curve2D.new()
	for cell in path:
		enemy_curve.add_point(calculate_map_position(cell))

	return enemy_curve

func _create_rounded_enemy_curve(path) -> Curve2D:
	var enemy_curve = Curve2D.new()
	enemy_curve.add_point(calculate_map_position(path[0]))
	for i in path.size()-1:
		if i < path.size()-2:
			var q0 = path[i].linear_interpolate(path[i+1], 0)
			var q1 = path[i+1].linear_interpolate(path[i+2], 0)
			var r = q0.linear_interpolate(q1, 0.75)
			enemy_curve.add_point(calculate_map_position(r))
			
	enemy_curve.add_point(calculate_map_position(path[path.size()-1]))
	return enemy_curve

func calculate_map_position(grid_position: Vector2) -> Vector2:
	return grid_position * cell_size + cell_size/2

func get_cells():
	return cells

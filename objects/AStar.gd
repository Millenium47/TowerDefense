extends TileMap

const NEIGHBORS := [
	Vector2.UP,
	Vector2.LEFT,
	Vector2.RIGHT,
	Vector2.DOWN
]

onready var astar = AStar2D.new()

var path: PoolVector2Array

func _add_points(usable_cells: Array, weight: float) -> void:
	for cell in usable_cells:
		astar.add_point(id(cell), cell, weight)

func _connect_point(usable_cells: Array) -> void:
	for cell in usable_cells:
		for neighbor in NEIGHBORS:
			var next_cell = cell + neighbor
			if usable_cells.has(next_cell):
				astar.connect_points(id(cell), id(next_cell))
	
func get_astar_path(usable_cells: Array, road_cells: Array, start_cell: Vector2, end_cell: Vector2) -> PoolVector2Array:
	_add_points(usable_cells, 2)
	_add_points(road_cells, 1)
	_connect_point(usable_cells)
	return astar.get_point_path(id(start_cell), id(end_cell))

# Cantor pairing function
func id(point: Vector2) -> int:
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b

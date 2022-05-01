extends TileMap

const NEIGHBORS := [
	Vector2.UP,
	Vector2.LEFT,
	Vector2.RIGHT,
	Vector2.DOWN
]

onready var astar = AStar2D.new()

var path: PoolVector2Array

func _add_points(usable_cells, weight):
	for cell in usable_cells:
		astar.add_point(id(cell), cell, weight)

func _connect_point(usable_cells):
	for cell in usable_cells:
		for neighbor in NEIGHBORS:
			var next_cell = cell + neighbor
			if usable_cells.has(next_cell):
				astar.connect_points(id(cell), id(next_cell))
	
func get_astar_path(usable_cells, road_cells, start_cell, end_cell):
	_add_points(usable_cells, 2)
	_add_points(road_cells, 1)
	_connect_point(usable_cells)
	return astar.get_point_path(id(start_cell), id(end_cell))

# Cantor pairing function
func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b

extends Tower

onready var arrow = preload("res://objects/projectiles/Arrow.tscn")

func _ready():
	shoot_position = $ShootPosition.position
	projectile = arrow

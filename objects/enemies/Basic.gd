extends Enemy

var cost = GameData.enemies["Basic"]["cost"]

func _ready():
	speed = GameData.enemies["Basic"]["speed"]
	health = GameData.enemies["Basic"]["health"]
	damage = GameData.enemies["Basic"]["damage"]

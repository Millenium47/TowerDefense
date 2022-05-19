extends Enemy

func _init():
	speed = GameData.enemies["Basic"]["speed"]
	health = GameData.enemies["Basic"]["health"]
	cost = GameData.enemies["Basic"]["cost"]
	damage = GameData.enemies["Basic"]["damage"]

extends Enemy

var cost = GameData.enemies["Elite"]["cost"]

func _ready():
	speed = GameData.enemies["Elite"]["speed"]
	health = GameData.enemies["Elite"]["health"]
	damage = GameData.enemies["Elite"]["damage"]

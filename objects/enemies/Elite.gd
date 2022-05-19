extends Enemy

func _init():
	speed = GameData.enemies["Elite"]["speed"]
	health = GameData.enemies["Elite"]["health"]
	cost = GameData.enemies["Elite"]["cost"]
	damage = GameData.enemies["Elite"]["damage"]
	
func set_damage(damage):
	$KinematicBody2D/Hitbox.damage = damage

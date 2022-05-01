extends PathFollow2D

var speed = GameData.enemies["Elite"]["speed"]
var health = GameData.enemies["Elite"]["health"]
var damage = GameData.enemies["Elite"]["damage"]
var cost = GameData.enemies["Elite"]["cost"]

func _physics_process(delta):
	set_offset(get_offset() + speed * delta)

func on_hit(taken_damage):
	health -= taken_damage
	if health <= 0:
		_on_destroy()

func _on_destroy():
	queue_free()

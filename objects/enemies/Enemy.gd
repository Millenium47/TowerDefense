extends PathFollow2D

var speed = GameData.enemies["Basic"]["speed"]
var health = GameData.enemies["Basic"]["health"]
var damage = GameData.enemies["Basic"]["damage"]
var cost = GameData.enemies["Basic"]["cost"]

func _physics_process(delta):
	set_offset(get_offset() + speed * delta)

func on_hit(taken_damage):
	health -= taken_damage
	if health <= 0:
		_on_destroy()

func _on_destroy():
	queue_free()

class_name Tower
extends Node2D

var enemies = []
var enemy
var type
var ready = true
var built = false

func _ready():
	self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.buildings[type]["range"]

func _physics_process(delta):
	if enemies.size() != 0 and built:
		_select_enemy()
		if ready:
			_fire()
	else:
		enemy = null

func _fire():
	ready = false
	enemy.on_hit(GameData.buildings[type]["damage"])
	yield(get_tree().create_timer(GameData.buildings[type]["rof"]), "timeout")
	ready = true

func _select_enemy():
	var enemies_progress = []
	for i in enemies:
		enemies_progress.append(i.offset)
		var enemy_index = enemies_progress.find(enemies_progress.max())
		enemy = enemies[enemy_index]
	
func _on_Range_body_entered(body):
	enemies.append(body.get_parent())

func _on_Range_body_exited(body):
	enemies.erase(body.get_parent())

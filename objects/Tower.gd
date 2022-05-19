class_name Tower
extends Node2D

var enemies = []
var enemy
var type
var shoot_position
var projectile
var damage
var ready = true
var built = false

func _ready():
	self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.buildings[type]["range"]

func _physics_process(_delta):
	if enemies.size() != 0 and built:
		_select_enemy()
		if ready:
			_fire()
	else:
		enemy = null

func _fire() -> void:
	ready = false
	_spawn_projectile(enemy.global_position)
	yield(get_tree().create_timer(GameData.buildings[type]["rof"]), "timeout")
	ready = true

func _spawn_projectile(_current_enemy_pos: Vector2) -> void:
	var _projectile = projectile.instance()
	_projectile.set_damage(damage)
	_projectile.global_position = shoot_position
	_projectile.rotation = Vector2(1,0).angle_to((_current_enemy_pos - global_position).normalized())
	add_child(_projectile)
	
func _select_enemy() -> void:
	var enemies_progress = []
	for i in enemies:
		enemies_progress.append(i.offset)
		var enemy_index = enemies_progress.find(enemies_progress.max())
		enemy = enemies[enemy_index]
	
func _on_Range_body_entered(body) -> void:
	enemies.append(body.get_parent())

func _on_Range_body_exited(body) -> void:
	enemies.erase(body.get_parent())

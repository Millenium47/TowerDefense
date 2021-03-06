extends Node2D

signal destroyed

var cell
var max_health = GameData.buildings["Castle"]["health"]
var max_num_buildings = GameData.buildings["Castle"]["buildings"]

var health = max_health setget set_health
var num_buildings = max_num_buildings

func set_health(new_health: int) -> void:
	health = new_health

func _destroy() -> void:
	emit_signal("destroyed")
	# Make a deferred call to prevent errors
	$Hurtbox.set_deferred("monitorable", false)

func _on_Hurtbox_area_entered(hitbox: Area2D) -> void:
	set_health(health - hitbox.damage)
	if health <= 0:
		_destroy()

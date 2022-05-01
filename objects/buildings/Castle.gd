extends Node2D

signal destroyed

var cell
var max_health = GameData.building_data["Castle"]["health"]
var max_num_buildings = GameData.building_data["Castle"]["buildings"]

var health = max_health setget set_health
var num_buildings = max_num_buildings

func set_health(new_health):
	health = new_health

func _destroy() -> void:
	emit_signal("destroyed")
	# Make a deferred call to prevent errors
	$Hurtbox.set_deferred("monitorable", false)

func _on_Hurtbox_hit_landed(damage):
	set_health(health - damage)

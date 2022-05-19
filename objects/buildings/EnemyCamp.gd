class_name EnemyCamp
extends Node2D

signal spawn_next_wave(size, camp_name)

var cell
var level := 1

func _on_SpawnTimer_timeout() -> void:
	emit_signal("spawn_next_wave", 10, get_name())

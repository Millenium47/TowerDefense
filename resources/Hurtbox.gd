extends Area2D

signal hit_landed(damage)

func get_hurt(damage: int) -> void:
	emit_signal("got_hurt", damage)

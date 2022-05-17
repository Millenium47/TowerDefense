class_name HurtBox
extends Area2D

signal got_hurt(damage)

func get_hurt(damage: int) -> void:
	emit_signal("got_hurt", damage)

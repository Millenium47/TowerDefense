class_name HitBox
extends Area2D

func apply_hit(hurt_box: HurtBox, damage: int, multi_hit: bool) -> void:
	hurt_box.get_hurt(damage)
	set_deferred("monitoring", multi_hit) 


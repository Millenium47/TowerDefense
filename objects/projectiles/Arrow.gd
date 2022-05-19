extends Projectile

func set_damage(damage: int) -> void:
	$Hitbox.damage = damage

func _on_Hitbox_area_entered(area: Area2D) -> void:
	queue_free()

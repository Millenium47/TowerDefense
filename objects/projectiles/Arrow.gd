extends Projectile

var damage := 1

func _on_Hitbox_area_entered(area: Area2D) -> void:
	$Hitbox.apply_hit(area, damage, false)
	queue_free()

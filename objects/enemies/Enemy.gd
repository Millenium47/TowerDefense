class_name Enemy
extends PathFollow2D

var speed
var health
var cost
var damage

func _physics_process(delta):
	set_offset(get_offset() + speed * delta)

func set_damage(damage: int) -> void:
	$KinematicBody2D/Hitbox.damage = damage

func _on_destroy() -> void:
	queue_free()

func _on_Hurtbox_area_entered(hitbox: Area2D) -> void:
	health -= hitbox.damage
	if health <= 0:
		_on_destroy()
		
func _on_Hitbox_area_entered(hurtbox: Area2D) -> void:
	queue_free()

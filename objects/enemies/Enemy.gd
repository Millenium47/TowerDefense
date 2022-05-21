class_name Enemy
extends PathFollow2D

signal enemy_died(gold)

var speed
var health
var current_health
var cost
var damage

func _physics_process(delta):
	set_offset(get_offset() + speed * delta)

func set_damage(_damage: int) -> void:
	$KinematicBody2D/Hitbox.damage = _damage

func _on_destroy() -> void:
	emit_signal("enemy_died", cost)
	queue_free()

func _on_Hurtbox_area_entered(hitbox: Area2D) -> void:
	current_health -= hitbox.damage
	var progress =int(float(float (current_health) / float (health)) * 100)
	get_node("HPBar").value = progress
	if current_health <= 0:
		_on_destroy()
		
func _on_Hitbox_area_entered(_hurtbox: Area2D) -> void:
	queue_free()

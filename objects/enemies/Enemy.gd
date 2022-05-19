class_name Enemy
extends PathFollow2D

var speed
var health
var damage

func _physics_process(delta):
	set_offset(get_offset() + speed * delta)

func _on_destroy():
	queue_free()

func _on_Hurtbox_area_entered(hitbox):
	health -= hitbox.damage
	print("enemy hurtbox entered ", health)
	if health <= 0:
		_on_destroy()

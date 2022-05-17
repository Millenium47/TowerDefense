class_name Projectile
extends Node2D

var speed = 250

func _physics_process(delta):
	var velocity = Vector2(speed * delta, 0)
	position += velocity.rotated(rotation)

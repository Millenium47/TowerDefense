class_name Player
extends Node

signal gold_changed(gold_amount)

export var gold := 50 setget set_gold

func add_gold(amount: int) -> void:
	gold += amount
	emit_signal("gold_changed", gold)

func remove_gold(amount: int) -> void:
	gold -= amount
	emit_signal("gold_changed", gold)
		
func set_gold(new_amount: int) -> void:
	gold = new_amount
	emit_signal("gold_changed", gold)

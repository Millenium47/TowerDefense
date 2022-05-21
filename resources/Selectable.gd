class_name Selectable
extends Area2D

signal selection_changed
 
var selected := false setget set_selected 

func _ready() -> void:
	set_process_unhandled_input(false)

func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("select_area"):
		set_selected(true)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("select_area"):
		set_selected(false)
		set_process_unhandled_input(false)
	
func set_selected(_selected: bool) -> void:
	selected = _selected
	emit_signal("selection_changed", selected)

func _on_SelectableArea_mouse_entered() -> void:
	set_process_unhandled_input(false)


func _on_SelectableArea_mouse_exited() -> void:
	set_process_unhandled_input(selected)

extends Node


func _ready():
	get_node("MainMenu/EdgeMargin/VBoxContainer/NewGame").connect("pressed", self, "on_new_game_pressed")
	get_node("MainMenu/EdgeMargin/VBoxContainer/Quit").connect("pressed", self, "on_quit_pressed")
	
func on_new_game_pressed() -> void:
	get_node("MainMenu").queue_free()
	var game_scene = load("res://UI/GameScene.tscn").instance()
	add_child(game_scene)
	
func on_quit_pressed() -> void:
	get_tree().quit()

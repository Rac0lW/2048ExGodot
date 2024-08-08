extends Node2D
func _ready():
	Engine.time_scale = 1.0
	
func _on_quit_game_pressed():
	get_tree().quit()



extends Node

func _on_play_button_pressed():
	var main_scene = load("res://scenes/main.tscn")
	get_tree().change_scene_to_packed(main_scene)

func _on_quit_button_pressed():
	get_tree().quit()

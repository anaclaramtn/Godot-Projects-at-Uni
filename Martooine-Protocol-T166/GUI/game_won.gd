extends Control

@export var main_menu_scene_path: String = "res://GUI/menu_inicial.tscn"

func _ready():
	$HBoxContainer/MainMenuButton.pressed.connect(_on_main_menu_pressed)
	$HBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)

func _on_main_menu_pressed():
	get_tree().change_scene_to_file(main_menu_scene_path)
	HealthManager.current_health = 3  # reseta vida do player

func _on_quit_pressed():
	get_tree().quit()

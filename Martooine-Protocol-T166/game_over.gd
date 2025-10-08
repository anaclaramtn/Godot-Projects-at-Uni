extends Control

@export var boss_scene_path: String = "res://LEVELS/bossScene.tscn"
@export var main_menu_scene_path: String = "res://GUI/menu_inicial.tscn"

func _ready():
	# Conecta os botões aos métodos
	$VBoxContainer/RetryButton.pressed.connect(_on_retry_pressed)
	$VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu_pressed)
	$VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)

func _on_retry_pressed():
	get_tree().change_scene_to_file('res://LEVELS/mainLevel.tscn')
	HealthManager.current_health = 3

func _on_main_menu_pressed():
	get_tree().change_scene_to_file(main_menu_scene_path)
	HealthManager.current_health = 3

func _on_quit_pressed():
	get_tree().quit()

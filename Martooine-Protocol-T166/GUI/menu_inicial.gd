class_name mainMenu
extends Control

@onready var start_button: Button = $HBoxContainer/startButton
@onready var quit_button: Button = $HBoxContainer/quitButton


@export var intro = preload("res://GUI/intro_cutscene.tscn")
@export var mainLevel = preload("res://LEVELS/mainLevel.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_start_pressed)
	quit_button.button_down.connect(on_quit_pressed)

func on_start_pressed():
	get_tree().change_scene_to_packed(intro)

func on_quit_pressed():
	get_tree().quit()

extends Control

@export var next_scene_path: String = "res://LEVELS/mainLevel.tscn"
@onready var timer: Timer = $CutsceneTimer
@onready var label: Label = $VBoxContainer/Label

func _ready():
	# Texto da historinha
	# Inicia timer (se não autostart)
	# timer.start()

	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	# Troca de cena após 5 segundos
	get_tree().change_scene_to_file(next_scene_path)

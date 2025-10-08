extends Node2D

@export var heartFULL : Texture2D
@export var heartEMPTY : Texture2D


@onready var heart01: Sprite2D = $Sprite2D
@onready var heart02: Sprite2D = $Sprite2D2
@onready var heart03: Sprite2D = $Sprite2D3

func _ready() -> void:
	HealthManager.on_health_changed.connect(on_player_health_changed)

func on_player_health_changed(player_current_health: int):
	if player_current_health == 3:
		heart03.texture = heartFULL
	elif player_current_health < 3:
		heart03.texture = heartEMPTY
	
	
	if player_current_health == 2:
		heart02.texture = heartFULL
	elif player_current_health < 2:
		heart02.texture = heartEMPTY
	
	if player_current_health == 1:
		heart01.texture = heartFULL
	elif player_current_health < 1:
		heart01.texture = heartEMPTY

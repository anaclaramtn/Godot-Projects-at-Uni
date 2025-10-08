extends Camera2D

@onready var camera_2d: Camera2D = $"."

func _ready():
	camera_2d.limit_left = 0
	camera_2d.limit_right = -320 + 640  # ajuste conforme a largura total do parallax
	camera_2d.limit_top = 0
	camera_2d.limit_bottom = -10000000  # ou altura total

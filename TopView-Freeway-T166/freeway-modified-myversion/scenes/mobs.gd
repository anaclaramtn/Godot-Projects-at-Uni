extends CharacterBody2D

@export var speed = 100

@onready var animation = $AnimatedSprite2D

@export var mob_name = "orc-normal-run"


func _physics_process(_delta):
	# Apenas move o mob para a direita (sentido positivo do eixo X)
	velocity.x = speed
	move_and_slide()
	
func _ready():
	animation.play(mob_name)

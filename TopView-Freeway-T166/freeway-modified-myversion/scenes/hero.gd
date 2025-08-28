extends CharacterBody2D

@export var speed = 100
@onready var animation = $AnimatedSprite2D


func _physics_process(_delta):
	var input_direction = Vector2.ZERO
	input_direction.x = Input.get_axis("ui_left", "ui_right")
	input_direction.y = Input.get_axis("ui_up", "ui_down")

	input_direction = input_direction.normalized()
	velocity = input_direction * speed

	move_and_slide()
	
	if input_direction.length() > 0:
		if abs(input_direction.x) > abs(input_direction.y):
			if input_direction.x > 0:
				animation.play("run-right")
			else:
				animation.play("run-left")
		else:
			if input_direction.y > 0:
				animation.play("run-down")
			else:
				animation.play("run-up")
	else:
		if animation.animation.begins_with("run"):
			var idle_anim = animation.animation.replace("run", "idle")
			animation.play(idle_anim)

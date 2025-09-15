extends Area2D

class_name Enemy

@export var h_speed: float = 20
@export var v_speed: float = 100
@onready var ray_cast_2d = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	position.x -= h_speed * delta
	if !ray_cast_2d.is_colliding():
		position.y += v_speed * delta

func _die():
	h_speed = 0
	v_speed = 0
	animated_sprite_2d.play("dead")

func _die_from_hit():
	h_speed = 0
	v_speed = 0
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	
	rotation_degrees = 180
	var die_tween = get_tree().create_tween()
	die_tween.tween_property(self, "position", position + Vector2(0, -25), 0.2)
	die_tween.chain().tween_property(self, "position", position + Vector2(0, 400), 4)

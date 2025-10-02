extends CharacterBody2D

@export var patrol_points : Node
@export var speed : int = 5000
@export var wait_time : int = 3 

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var gravity = 1000

enum State { Idle, Walk }
var current_state : State
var direction : Vector2 = Vector2.LEFT
var number_of_points : int
var point_positions : Array [Vector2]
var current_point : Vector2
var current_point_position : int
var can_walk : bool

func _ready() -> void:
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("no patrol points")
	
	timer.wait_time = wait_time
	
	current_state = State.Idle


func _physics_process(delta: float) -> void:
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	
	move_and_slide()
	

func enemy_gravity(delta: float):
	velocity.y += gravity * delta


func enemy_idle(delta: float):
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		current_state = State.Idle

func enemy_walk(delta : float):
	if !can_walk:
		return
	
	if abs(position.x - current_point.x) >  0.5:
		velocity.x = direction.x * speed * delta
		current_state = State.Walk
	else:
		current_point_position = (current_point_position + 1) % point_positions.size()
		current_point = point_positions[current_point_position]

	if current_point.x > position.x:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
		
	animated_sprite_2d.flip_h = direction.x > 0


func _on_timer_timeout() -> void:
	can_walk = true

func enemy_animation():
	if current_state == State.Idle && !can_walk:
		animated_sprite_2d.play("idle")
	elif current_state == State.Walk && can_walk:
		animated_sprite_2d.play("walk")

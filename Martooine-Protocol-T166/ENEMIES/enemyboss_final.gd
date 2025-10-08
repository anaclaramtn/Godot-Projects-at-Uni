extends CharacterBody2D

var enemy_death_effect = preload("res://SCENES/enemy_death_effect.tscn")

@export var patrol_points : Node
@export var speed : int = 7000
@export var wait_time : int = 4

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

@export var health_amount : int = 20
@export var damage_amount : int = 1

@onready var ganhou: AudioStreamPlayer = $"../AudioStreamPlayer"


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
	enemy_animation()
	
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


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		health_amount -= node.damage_amount
		
		print("health amount: ", health_amount)
		
		if health_amount <= 0:
			var enemy_death_effect_instance = enemy_death_effect.instantiate() as Node2D
			enemy_death_effect_instance.global_position = global_position
			get_parent().add_child(enemy_death_effect_instance)
			
			
			var timer = get_tree().create_timer(2.5)
			await timer.timeout  # Godot 5 aceita await aqui
			
			ganhou.play()
			get_tree().change_scene_to_file('res://GUI/game_won.tscn')
			
			queue_free() 

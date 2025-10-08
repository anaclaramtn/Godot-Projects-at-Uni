extends CharacterBody2D

var bullet = preload("res://SCENES/bullet.tscn")


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var muzzle: Marker2D = $Muzzle

const gravity = 1000
@export var speed : int = 1000
@export var max_horizontal_speed: int = 250
@export var slow_speed : int = 1700

@export var jump = -310
@export var jump_horizontal_speed : int = 150

enum State {Idle, Run, Jump, Shoot}

var current_state = State.Idle
var muzzle_position : Vector2


func _ready():
	current_state = State.Idle
	muzzle_position = muzzle_position 

var last_direction = 1
func _physics_process(delta):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	
	player_muzzle_position()
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		last_direction = direction

	if Input.is_action_just_pressed("shoot"):
		player_shoot(delta)
	
	move_and_slide()
	
	player_animation()
	#print("State: ", State.keys()[current_state])
	# VERIFICAR O ESTADO DO PLAYER ESTA COMENTADO NO MOMENTO

func player_falling (delta):
	if !is_on_floor():
		velocity.y += gravity * delta

func player_idle(delta):
	if is_on_floor() and current_state != State.Shoot:
		current_state = State.Idle
		
#func player_idle(delta):
	#if is_on_floor():
		#current_state = State.Idle
		## print("State: ", State.keys()[current_state])

func player_run(delta):
	if !is_on_floor():
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x += direction * speed * delta
		velocity.x = clamp(velocity.x,-max_horizontal_speed,max_horizontal_speed)
	else:
		velocity.x = move_toward(velocity.x, 0 , slow_speed * delta)
		
	
	if direction != 0:
		current_state = State.Run
		# print("State: ", State.keys()[current_state])
		animated_sprite_2d.flip_h = false if direction > 0 else true

func player_jump(delta):
	# se a acao pressionada for pulo e o player estiver no chao
	if Input.is_action_just_pressed("jump") and is_on_floor(): 
		velocity.y = jump
		current_state = State.Jump
		
	if !is_on_floor() and current_state == State.Jump:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x += direction * jump_horizontal_speed * delta
		velocity.x = clamp(velocity.x,-jump_horizontal_speed,jump_horizontal_speed)


func player_shoot(delta):
	var bullet_instance = bullet.instantiate() as Node2D
	bullet_instance.direction = last_direction
	bullet_instance.global_position = muzzle.global_position
	get_parent().add_child(bullet_instance)
	current_state = State.Shoot

func player_muzzle_position():
	var direction = Input.get_axis("move_left","move_right")
	
	if last_direction > 0:
		muzzle.position.x = abs(muzzle.position.x)
	elif last_direction < 0:
		muzzle.position.x = -abs(muzzle.position.x)

func player_animation():
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")
	elif current_state == State.Shoot:
		animated_sprite_2d.play("shoot")


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		print('enemy entered ', body.damage_amount)
		print('amount of health = ', HealthManager.current_health)
		HealthManager.decrease_health(1)
	
	if HealthManager.current_health <= 0:
			game_over()
			
func game_over():
	get_tree().change_scene_to_file("res://GUI/game_over.tscn")

extends Area2D

#declaracao de variaveis
@export var speed: float = 150.0;
var screen_size: Vector2;
var initial_position: Vector2 = Vector2(640, 690);

signal score;

func _ready() -> void:
	screen_size = get_viewport_rect().size;
	position = initial_position;
	
func _process(delta):
	var velocity = Vector2.ZERO;
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1;
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1;
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1;
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1;
	
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed;
	
	position += velocity * delta;
	position.y = clamp(position.y, 0.0,  screen_size.y);
	
	if velocity.y > 0:
		$animation.play("baixo");
	elif velocity.y < 0:
		$animation.play("cima");
	elif velocity.x > 0:
		$animation.play("cima");
	elif velocity.x < 0:
		$animation.play("cima");
	else:
		$animation.stop();


func _on_body_entered(body: Node2D) -> void:
	if body.name == "finish_line":
		emit_signal("score");
		position = initial_position;
	else:
		$audio.play();
		position = initial_position;
	pass

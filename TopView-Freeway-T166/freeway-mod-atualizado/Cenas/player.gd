extends Area2D

@export var speed: float = 150.0;
var screen_size: Vector2;
@export var initial_position: Vector2 = Vector2(600, 640);
signal pontua

func _ready() -> void:
	screen_size = get_viewport_rect().size;
	position = initial_position;
	
func _process(delta):
	var velocity = Vector2.ZERO;
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1;
		$animation.play("cima");
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1;
		$animation.play("baixo");
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1;
		$animation.play("esquerda");
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1;
		$animation.play("direita");
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
	
	position += velocity * delta;
	position.y = clamp(position.y, 0.0,  screen_size.y);

	if velocity.length() == 0:
		$animation.stop();


func _on_body_entered(body):
	if body.name == "Terrain":
		emit_signal("pontua")
		position = initial_position
	else:
		$audio.play()
		position = initial_position

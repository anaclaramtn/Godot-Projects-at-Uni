extends Area2D
var speed: float = 100.0;
var screenSize: Vector2;
var initialPosition: Vector2 = Vector2(640, 690);

# @onready é uma forma fácil de pegar um nó filho.
@onready var animacao = $animacao # esse é o nó "animacao" que é child do player criado (a galinha);

func _ready() -> void:
	screenSize = get_viewport_rect().size;
	position = initialPosition;
	
func _process(delta: float) -> void:
	var current_velocity = Vector2.ZERO;
	
	if Input.is_action_pressed("ui_up"):
		current_velocity.y -= 1;
	if Input.is_action_pressed("ui_down"):
		current_velocity.y += 1;
	
	
	if current_velocity.y < 0:
		animacao.play("cima");
	elif current_velocity.y > 0:
		animacao.play("baixo");
	else:
		if current_velocity.x == 0 || current_velocity.y == 0: 
			animacao.stop()

	if current_velocity.length() > 0:
		current_velocity = current_velocity.normalized() * speed;

	position += current_velocity * delta;
	
	position.y = clamp(position.y, 0.0, screenSize.y);

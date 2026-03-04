extends RigidBody2D


func _ready() -> void:
	var typeCars = $animation.sprite_frames.get_animation_names();
	$animation.play()
	var car = typeCars[randi_range(0, typeCars.size() - 1)];
	
	$animation.animation = car;

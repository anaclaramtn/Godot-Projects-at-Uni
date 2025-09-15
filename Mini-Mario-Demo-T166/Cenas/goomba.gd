extends Enemy

class_name Goomba

func _die():
	super._die()
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	get_tree().create_timer(0,6).timeout.connect(queue_free)

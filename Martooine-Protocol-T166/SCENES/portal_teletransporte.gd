extends Area2D

@export var next_scene_path : String


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://LEVELS/bossScene.tscn")

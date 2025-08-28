extends Node2D

var mob_scene = preload("res://scenes/mobs.tscn")

var skeleton_names = [
	"ske-normal-run",
	"ske-warrior-run",
	"ske-rogue-run",
	"ske-mage-run"
]

var orc_names = [
	"orc-normal-run",
	"orc-warrior-run",
	"orc-rogue-run",
	"orc-mage-run"
]

var mob_pos = [-4, 100, 160, 220, 280, 340, 400, 460, 520]

@onready var spawn_point = $SpawnPoint

func spawn_mob(mob_list: Array):
	# Pega uma faixa aleatoria
	var random_lane = mob_pos[randi() % mob_pos.size()]

	# Pega um mob aleatorio da lista fornecida
	var random_mob_name = mob_list[randi() % mob_list.size()]
	
	var new_mob = mob_scene.instantiate()
	new_mob.position.y = random_lane
	new_mob.position.x = spawn_point.position.x
	new_mob.mob_name = random_mob_name
	
	add_child(new_mob)
	
	

func _on_ske_spawn_timer_timeout() -> void:
	spawn_mob(skeleton_names)

func _on_orcs_spawn_timer_timeout() -> void:
	spawn_mob(orc_names)

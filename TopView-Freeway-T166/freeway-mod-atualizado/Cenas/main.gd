extends Node2D

const cena_mobs = preload("res://Cenas/Mobs.tscn")
var pistas_fastSke_y = [150, 250, 350]
var pistas_slowOrcs_y = [400, 450, 500, 550, 600]
var score = 0


func _ready():
	$HUD/Placar.text = str(score)
	$HUD/Messagem.text = " "
	$HUD/Button.hide()
	$AudioTema.play()
	randomize()

func _on_timer_skels_rapido_timeout():
	var mob = cena_mobs.instantiate()
	add_child(mob)
	var pista_y = pistas_fastSke_y[randi_range(0, pistas_fastSke_y.size() - 1)]
	mob.position = Vector2(-10, pista_y)
	mob.set_linear_velocity(Vector2(randf_range(700, 710), 0))
	mob.set_linear_damp(0.0)


func _on_timer_orcs_lentos_timeout():
	var mob = cena_mobs.instantiate()
	add_child(mob)
	var pista_y = pistas_slowOrcs_y[randi_range(0, pistas_slowOrcs_y.size() - 1)]
	mob.position = Vector2(-10, pista_y)
	mob.set_linear_velocity(Vector2(randf_range(300, 310), 0))
	mob.set_linear_damp(0.0)

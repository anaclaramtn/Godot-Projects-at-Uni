extends Node

var scene_cars = preload("res://scenes/cars.tscn");
var fast_lanes_y = [104, 272, 488];
var slow_lanes_y = [160, 216, 324, 384, 438, 544, 600];

var score = 0;

func _ready() -> void:
	$HUD/scoreboard.text = str(score);
	$HUD/messageLose.hide();
	$HUD/messageWon.hide();
	$HUD/button.hide();
	$audioTheme.play();
	randomize();

func _on_timer_fast_cars_timeout() -> void:
	var car = scene_cars.instantiate();
	add_child(car);
	var lane_y = fast_lanes_y[randi_range(0, fast_lanes_y.size() - 1)];
	car.position = Vector2(-10,lane_y);
	car.set_linear_velocity(Vector2(randf_range(750, 800), 0));
	car.set_linear_damp(0.0);

func _on_timer_slow_cars_timeout() -> void:
	var car = scene_cars.instantiate();
	add_child(car);
	var lane_y = slow_lanes_y[randi_range(0, slow_lanes_y.size() - 1)];
	car.position = Vector2(-10,lane_y);
	car.set_linear_velocity(Vector2(randf_range(400, 500), 0));
	car.set_linear_damp(0.0);

func _on_player_score() -> void:
	if score <= 10:
		score += 1;
		$HUD/scoreboard.text = str(score);
		$audioScore.play();
	if score == 10:
		$HUD/messageWon.show();
		$HUD/button.show();
		$timerFastCars.stop();
		$timerSlowCars.stop();
		$audioWin.play();


func _on_hud_again() -> void:
	get_tree().reload_current_scene();

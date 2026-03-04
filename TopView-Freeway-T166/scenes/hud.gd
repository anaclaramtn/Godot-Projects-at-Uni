extends CanvasLayer

signal again;

func _on_button_pressed() -> void:
	emit_signal("again");
	

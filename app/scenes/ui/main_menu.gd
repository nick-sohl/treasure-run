extends Control

func _ready() -> void:
	$CenterContainer/VBoxContainer/StartButton.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level/Level.tscn")

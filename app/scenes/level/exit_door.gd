extends Area2D

const TEXTURE_LOCKED = preload("res://assets/sprites/door_locked.png")
const TEXTURE_OPEN = preload("res://assets/sprites/door_open.png")

signal player_entered

var is_open := false

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func open() -> void:
	is_open = true
	sprite.texture = TEXTURE_OPEN

func _on_body_entered(body: Node2D) -> void:
	if is_open and body.is_in_group("player"):
		player_entered.emit()

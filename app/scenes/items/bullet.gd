extends Area2D

const SPEED = 500.0

var direction := 1.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	$Timer.timeout.connect(_on_timer_timeout)

func _process(delta: float) -> void:
	position.x += direction * SPEED * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.has_method("die"):
		body.die()
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()

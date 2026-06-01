extends CharacterBody2D

const SPEED = 60.0
const GRAVITY = 980.0

signal died

var direction := 1.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var edge_ray: RayCast2D = $EdgeRay

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if is_on_wall() or (is_on_floor() and not edge_ray.is_colliding()):
		_reverse()

	velocity.x = direction * SPEED

	move_and_slide()
	_check_player_contact()

func _reverse() -> void:
	direction *= -1.0
	sprite.flip_h = direction < 0.0
	edge_ray.position.x = 30.0 * direction

func _check_player_contact() -> void:
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider.is_in_group("player"):
			collider.die()
			return

func die() -> void:
	died.emit()
	queue_free()

extends CharacterBody2D

const SPEED = 130.0
const JUMP_FORCE = 330.0
const GRAVITY = 800.0
const START_AMMO = 5

const BULLET_SCENE = preload("res://scenes/items/Bullet.tscn")

signal key_collected
signal ammo_changed(new_ammo: int)

var ammo := START_AMMO
var has_key := false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_FORCE

	if Input.is_action_just_pressed("shoot"):
		_shoot()

	move_and_slide()
	_update_animation(direction)

func _shoot() -> void:
	if ammo <= 0:
		return
	ammo -= 1
	ammo_changed.emit(ammo)
	var bullet = BULLET_SCENE.instantiate()
	var dir := -1.0 if sprite.flip_h else 1.0
	bullet.direction = dir
	bullet.global_position = global_position + Vector2(12.0 * dir, -6.0)
	get_tree().current_scene.call_deferred("add_child", bullet)

func collect_key() -> void:
	has_key = true
	key_collected.emit()

func collect_ammo(amount: int) -> void:
	ammo += amount
	ammo_changed.emit(ammo)

func die() -> void:
	get_tree().call_deferred("reload_current_scene")

func _update_animation(direction: float) -> void:
	if not is_on_floor():
		if velocity.y < 0.0:
			sprite.play("jump")
		else:
			sprite.play("fall")
	elif direction != 0.0:
		sprite.play("walk")
		sprite.flip_h = direction < 0.0
	else:
		sprite.play("idle")

extends Node2D

@export_file("*.tscn") var next_level_path: String

var enemies_alive := 0
var enemies_total := 0

@onready var exit_door = $ExitDoor
@onready var win_screen = $WinScreen
@onready var player = $Player
@onready var hud = $HUD

func _ready() -> void:
	$Killzone.body_entered.connect(_on_killzone_body_entered)
	exit_door.player_entered.connect(_on_exit_entered)
	player.key_collected.connect(_on_key_collected)

	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemies_alive += 1
		enemy.died.connect(_on_enemy_died)

	enemies_total = enemies_alive
	hud.setup(player, enemies_total)

func _on_killzone_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()

func _on_key_collected() -> void:
	_check_win_condition()

func _on_enemy_died() -> void:
	enemies_alive -= 1
	hud.update_enemies(enemies_alive, enemies_total)
	_check_win_condition()

func _check_win_condition() -> void:
	if player.has_key and enemies_alive == 0:
		exit_door.open()

func _on_exit_entered() -> void:
	if next_level_path != null and next_level_path != "":
		get_tree().call_deferred("change_scene_to_file", next_level_path)
	else:
		win_screen.visible = true
		get_tree().paused = true

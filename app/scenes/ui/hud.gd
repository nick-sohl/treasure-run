extends CanvasLayer

@onready var ammo_label: Label = $AmmoLabel
@onready var key_icon: TextureRect = $KeyIcon
@onready var enemy_label: Label = $EnemyLabel

func setup(player: CharacterBody2D, total_enemies: int) -> void:
	ammo_label.text = "Ammo: %d" % player.ammo
	update_enemies(total_enemies, total_enemies)
	player.ammo_changed.connect(_on_ammo_changed)
	player.key_collected.connect(_on_key_collected)

func update_enemies(alive: int, total: int) -> void:
	enemy_label.text = "Enemies: %d / %d" % [alive, total]

func _on_ammo_changed(new_ammo: int) -> void:
	ammo_label.text = "Ammo: %d" % new_ammo

func _on_key_collected() -> void:
	key_icon.modulate = Color.WHITE

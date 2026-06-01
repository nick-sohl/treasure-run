extends Area2D

enum CrateType { AMMO, KEY }

const AMMO_AMOUNT = 5

@export var crate_type: CrateType = CrateType.AMMO

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	match crate_type:
		CrateType.KEY:
			body.collect_key()
		CrateType.AMMO:
			body.collect_ammo(AMMO_AMOUNT)
	queue_free()

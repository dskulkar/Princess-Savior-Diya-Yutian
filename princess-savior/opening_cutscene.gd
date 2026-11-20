
extends Node2D

@onready var crown: Sprite2D = $Crown

func _ready() -> void:
	play_crown_animation()

func play_crown_animation() -> void:
	crown.position = Vector2(570, 350)

	await get_tree().create_timer(1.0).timeout

	var tween = create_tween()

	tween.tween_property(
		crown,
		"position",
		Vector2(900, 100),
		2.0
	)

	await tween.finished

	crown.visible = false

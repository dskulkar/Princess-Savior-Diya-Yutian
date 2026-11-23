
extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wand: Sprite2D = $Wand

var is_open: bool = false
var wand_collected: bool = false


func _ready() -> void:
	# Hide wand before opening chest
	wand.visible = false
	wand.remove_from_group("wands")

	print("Chest is ready!")


func open_chest() -> void:
	# Prevent opening twice
	if is_open:
		print("Chest is already open!")
		return

	# Check opening animation
	if not animation_player.has_animation("open_chest"):
		print("ERROR: open_chest animation not found!")
		return

	is_open = true

	print("Opening chest...")

	# Play chest opening animation
	animation_player.play("open_chest")
	await animation_player.animation_finished

	# Show magic wand
	wand.visible = true

	# Play wand appearance animation
	if animation_player.has_animation("wand_appear"):
		print("Magic wand appearing!")

		animation_player.play("wand_appear")
		await animation_player.animation_finished

	# Allow player to pick up wand
	if is_instance_valid(wand):
		wand.add_to_group("wands")

	print("Chest opened! Wand is ready!")


extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wand: Sprite2D = $Wand

signal chest_opened

var is_open: bool = false
var wand_collected: bool = false
var player_nearby: bool = false
var wand_ready: bool = false


func _ready() -> void:
	# Hide wand before opening chest
	wand.visible = false
	wand.remove_from_group("wands")

	# Connect player detection signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	print("Chest is ready!")


func _process(_delta: float) -> void:
	# Press E to open chest
	if player_nearby and Input.is_action_just_pressed("interact"):
		open_chest()

	# Press Space to collect wand
	if player_nearby and wand_ready and not wand_collected:
		if Input.is_key_pressed(KEY_SPACE):
			collect_wand()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_nearby = true
		print("Player near chest!")


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_nearby = false
		print("Player left chest!")


func open_chest() -> void:
	# Prevent opening twice
	if is_open:
		return

	# Check opening animation
	if not animation_player.has_animation("open_chest"):
		print("ERROR: open_chest animation not found!")
		return

	is_open = true
	print("Opening chest...")
	chest_opened.emit()
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

	# Allow player to collect wand
	if is_instance_valid(wand):
		wand.add_to_group("wands")
		wand_ready = true

	print("Chest opened! Wand is ready!")


func collect_wand() -> void:
	# Prevent collecting twice
	if wand_collected or not wand_ready:
		return

	wand_collected = true
	wand_ready = false

	# Hide wand after collection
	wand.visible = false
	wand.remove_from_group("wands")

	print("Magic wand collected!")


func _on_chest_opened() -> void:
	pass # Replace with function body.

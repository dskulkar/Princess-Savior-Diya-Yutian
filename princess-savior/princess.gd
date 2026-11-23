
extends CharacterBody2D

# Player movement settings
@export var speed: float = 100.0
@export var acceleration: float = 0.05
@export var decelaration: float = 0.08

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Interaction settings
@export var interaction_distance: float = 100.0

# Player inventory
var has_wand: bool = false

# Nearby objects
var nearby_chest: Node2D = null
var nearby_wand: Node2D = null


func _physics_process(delta: float) -> void:
	_get_input()

	if velocity.x > 0:
		animated_sprite.play("walk")
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.play("walk")
		animated_sprite.flip_h = true


func _get_input() -> void:
	# Move right and left
	if Input.is_action_pressed("move_right"):
		velocity.x = lerp(velocity.x, speed, acceleration)
	elif Input.is_action_pressed("move_left"):
		velocity.x = lerp(velocity.x, -speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, decelaration)

	# Move up and down
	if Input.is_action_pressed("move_down"):
		velocity.y = lerp(velocity.y, speed, acceleration)
	elif Input.is_action_pressed("move_up"):
		velocity.y = lerp(velocity.y, -speed, acceleration)
	else:
		velocity.y = lerp(velocity.y, 0.0, decelaration)

	move_and_slide()


func _ready() -> void:
	print("Princess is ready!")


func _process(delta: float) -> void:
	# Detect nearby chest and wand
	find_nearby_objects()

	# Press E to open chest
	if Input.is_action_just_pressed("interact"):
		interact_with_chest()

	# Press Space to pick up wand
	if Input.is_action_just_pressed("pickup"):
		pickup_wand()


func find_nearby_objects() -> void:
	nearby_chest = null
	nearby_wand = null

	# Find all chests
	var chests = get_tree().get_nodes_in_group("chests")

	for chest in chests:
		if chest is Node2D:
			# Detect actual chest sprite position
			var chest_sprite = chest.get_node_or_null("Sprite2D")

			if chest_sprite != null:
				var distance = global_position.distance_to(
					chest_sprite.global_position
				)

				if distance <= interaction_distance:
					nearby_chest = chest
					break

	# Find all available wands
	var wands = get_tree().get_nodes_in_group("wands")

	for wand in wands:
		if wand is Node2D:
			if not wand.visible:
				continue

			var distance = global_position.distance_to(
				wand.global_position
			)

			if distance <= interaction_distance:
				nearby_wand = wand
				break


func interact_with_chest() -> void:
	print("E key pressed!")

	if nearby_chest == null:
		print("No chest detected!")
		return

	print("Chest detected!")

	if nearby_chest.has_method("open_chest"):
		nearby_chest.open_chest()
	else:
		print("ERROR: Chest has no open_chest function!")


func pickup_wand() -> void:
	print("Space key pressed!")

	if has_wand:
		print("Princess already has the wand!")
		return

	if nearby_wand == null:
		print("No wand detected!")
		return

	has_wand = true

	print("Princess picked up the magic wand!")

	nearby_wand.queue_free()

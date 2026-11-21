extends CharacterBody2D
@export var speed: float = 100.0
@export var acceleration:float = 0.05
@export var decelaration: float = 0.08
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta:float)->void:
	_get_input()
	if velocity.x>0:
		animated_sprite.play("walk")
		animated_sprite.flip_h = false
	elif velocity.x<0:
		animated_sprite.flip_h = true

func _get_input()->void:
	if Input.is_action_pressed("move_right"):
		velocity.x=lerp(velocity.x,speed,acceleration)
	elif Input.is_action_pressed("move_left"):
		velocity.x = lerp(velocity.x, -speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, decelaration)
	if Input.is_action_pressed("move_down"):
		velocity.y = lerp(velocity.y, speed, acceleration)
	elif Input.is_action_pressed("move_up"):
		velocity.y = lerp(velocity.y, -speed, acceleration)
	else:
		velocity.y = lerp(velocity.y, 0.0, decelaration)
	
	move_and_slide()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends AnimatedSprite2D

@export var speed: float = 60.0
@export var left_limit: float = 100.0
@export var right_limit: float = 1000.0

var direction: int = 1

func _ready() -> void:
	play("walk")

func _process(delta: float) -> void:
	position.x += speed * direction * delta

	if position.x >= right_limit:
		position.x = right_limit
		direction = -1
		flip_h = true

	elif position.x <= left_limit:
		position.x = left_limit
		direction = 1
		flip_h = false

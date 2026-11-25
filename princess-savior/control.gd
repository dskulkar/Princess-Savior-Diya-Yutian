extends Control

@onready var diamond = $diamond

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	diamond.visible= false

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_chest_chest_opened() -> void:
	pass # Replace with function body.


func _on_animation_player_current_animation_changed(anim_name: StringName) -> void:
	diamond.visible = true

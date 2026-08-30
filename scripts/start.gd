extends Node2D
signal emit_position(position: Vector2)
var start_pos = Vector2(0,-14)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emit_signal("emit_position",start_pos)

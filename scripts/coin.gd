extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		auto_load.play_coin()
		queue_free()
		body.coins+=1

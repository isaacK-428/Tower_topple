extends StaticBody2D

signal next_level
var complete = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.hide()
	complete = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if complete==true:
		$AnimationPlayer.play("win")
		$Label.show()
		await get_tree().create_timer(2.5).timeout
		$Label.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("anything")
	if body.has_method("die"):
		body.active = false
		complete = true
		emit_signal("next_level")
		$AudioStreamPlayer.play()
		
		

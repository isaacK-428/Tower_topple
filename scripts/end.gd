extends StaticBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var you_win: Label = $Label
@onready var win_sound: AudioStreamPlayer = $AudioStreamPlayer
var complete = false
signal next_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	you_win.hide()
	complete = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if complete==true:
		animation_player.play("win")
		you_win.show()
		await get_tree().create_timer(2.5).timeout
		you_win.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.active = false
		complete = true
		emit_signal("next_level")
		win_sound.play()
		
		

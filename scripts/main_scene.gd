extends Node2D

#@onready var player: CharacterBody2D = $start/player
@onready var player: CharacterBody2D = $start/player

@export var next_level: PackedScene = null
@export var final_level: bool = false
var win_screen = preload("res://scenes/win_screeen.tscn")
var can_pick_up = false
var block = null
var win = false
var player_scene = preload("res://scenes/player.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win = false
	cheese.level()
	if final_level == true:
		pass
	#player.coins=cheese_coins
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func _on_end_next_level() -> void:
	#if next_level!=null:
	if  player&&player.active:
		player.active = false
	win = true
	var tween = create_tween()
	tween.tween_interval(2.0) # Wait for 2 seconds
	tween.tween_callback(end_level)


#func _on_start_emit_position(position: Vector2) -> void:
	#player.global_position = position
func end_level():
	cheese.coins=player.coins
	if next_level:
		get_tree().change_scene_to_packed(next_level)
	else:
		if final_level == true:
			$Label.show()
			print("final level")
			#$start/player/Node2D/death_screen.show()
			#$start/player/Node2D/ColorRect2.show()
			

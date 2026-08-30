extends Control

var first_level = preload("res://scenes/levels/level.tscn")
var a = AudioServer.get_bus_index("Master")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cheese.start_menu()
	AudioServer.set_bus_volume_db(a,linear_to_db($music.value))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	change()
	if Input.is_action_pressed("start"):
		get_tree().change_scene_to_file("res://scenes/levels/level.tscn")

func start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")


func quit_pressed() -> void:
	get_tree().quit()


func _on_music_changed() -> void:
	AudioServer.set_bus_volume_db(a,linear_to_db($music.value))
func change():
	AudioServer.set_bus_volume_db(a,linear_to_db($music.value))

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(a,linear_to_db(value))

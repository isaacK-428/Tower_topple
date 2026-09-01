extends Node
@onready var music: AudioStreamPlayer = $music_player
@onready var menu: AudioStreamPlayer = $menu
@onready var coin_player: AudioStreamPlayer = $coin_player
var last_song = null
var if_menu = false
var songs = [
	preload("res://assets/Electrified 2026-08-15 20_03_11.wav"),
	preload("res://assets/rusing winds .wav"),
	preload("res://assets/menu_song.wav")
]
var is_playing = false
var coins: int = 0
func _ready() -> void:	
	randomize()
	last_song = randi_range(0, 2)
func _on_audio_stream_player_finished() -> void:
	is_playing = false
	level()
func start_menu():
	if_menu=true
	is_playing = false
	music.stop()
	menu.play()
	if menu.playing!=false:
		menu.play()
func level():
	if_menu = false
	menu.stop()
	if !is_playing:
		var number = randi_range(0, 2)
		while last_song == number:
			number = randi_range(0, 2)
		last_song = number
		music.stream=songs[number]
		music.play()
		is_playing = true


func _on_menu_finished() -> void:
	is_playing = false
func play_coin():
	coin_player.play()
func _process(_delta: float):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

extends CharacterBody2D
var speed= 300.0

@export var JUMP_VELOCITY = -450
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var animation_player = $AnimatedSprite2D
@onready var jump_particles: GPUParticles2D = $GPUParticles2D2
@onready var ground_particles: GPUParticles2D = $ground_particles
@onready var label: Label = $Camera2D/Control/Label
var bullet = preload("res://scenes/bullet.tscn")

var level = 1
var heavy = preload("res://scenes/block_types/heavy_block.tscn")
var break_box = preload("res://scenes/break_box.tscn")
var C = preload("res://scenes/audio_stream_player.tscn")
var direction = 1
var was_in_air = false
var gravity = 7
var pound = false
var can_pick_up = false
var block = null
var active = true
var coins: int = 0
var gun = false
func _ready():
	randomize()
	active = true
func _physics_process(delta: float) -> void:
	label.text = "Coins: "+str(coins)
	if is_on_floor()&&velocity.x!=0:
		ground_particles.emitting = true
	else:
		ground_particles.emitting = false
	animation_player.scale.x = move_toward(animation_player.scale.x, 1.96, 5 * delta)
	animation_player.scale.y = move_toward(animation_player.scale.y, 1.96, 5 * delta)
	
	if animation_player.scale.y<=1.96:
		pass
	if velocity.y>500:
		velocity.y = 500
	if position.y>1515:
		pass
	
	
	move(delta)

	if is_on_floor():
		if was_in_air:
			was_in_air = false
			animation_player.scale = Vector2(2.3,1.96)
			$land.pitch_scale = randf_range(0.15,0.3)
			$land.play()
			if pound:
				pound = false
				particles.emitting=true
				particles.restart()
	else:
		was_in_air = true
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Check if the object we hit is a RigidBody2D
		if collider is RigidBody2D:
			if collider.is_in_group("block"):
				if collider.is_in_group("spikes"):
					die()
				if collider.block_type == "breakable":
					var break_I = break_box.instantiate()
					$Node.add_child(break_I)
					break_I.global_position = collider.global_position
					collider.break_it()
					break_I.emitting = true
					break_I.restart()
					$break_box.play()
					var C_I = C.instantiate()
					add_child(C_I)
				else:
					collider.apply_central_impulse(-collision.get_normal() * 200)
func move(delta):
	velocity.y+=gravity
	if Input.is_action_just_pressed("ground_pound")&&!is_on_floor():
		pound = true
		velocity.y=500
	direction = 0
	velocity.x/= 2
	if active==true:
		if Input.is_action_pressed("go_left"):
			direction = -1
		if Input.is_action_pressed("go_right"):
			direction = 1
		if Input.is_action_just_pressed("jump")&&is_on_floor():
			velocity.y=JUMP_VELOCITY
			$jump.play()
			$jump.pitch_scale = randf_range(0.8,1.2)
			jump_particles.emitting = true
			jump_particles.restart()
			animation_player.scale = Vector2(2,2.5)
			jump()
	if direction!=0:
		if direction>0:
			animation_player.flip_h=false

		else:
			animation_player.flip_h=true
			
		velocity.x= direction * speed
		if is_on_floor():
			animation_player.play("run")
		else:
			jump()
	else:
		if is_on_floor():
			animation_player.play("idle")
		else:
			jump()
	move_and_slide()
func jump():
	animation_player.play("jump")
	

func jumping():
	animation_player.play("jump")
	velocity.y=JUMP_VELOCITY
	$jump.play()
func die():
	global_position = Vector2(-600,-14)
	if get_tree():
		get_tree().reload_current_scene()


func _on_timer_timeout() -> void:
	coins = cheese.coins
func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

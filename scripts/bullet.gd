extends RigidBody2D
#extends CharacterBody2D
@export var block_type: String = ""
var direction = Vector2.ZERO
var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#linear_velocity=direction*speed
	apply_impulse(direction.normalized()*speed)
	#velocity=direction*speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
		#
		## Check if the object we hit is a RigidBody2D
		#if collider is RigidBody2D:
			#if collider.is_in_group("block"):
				#collider.apply_central_impulse(-collision.get_normal() * 2000)
	#move_and_slide()
	apply_impulse(direction.normalized()*speed)


func _on_timer_timeout() -> void:
	queue_free()

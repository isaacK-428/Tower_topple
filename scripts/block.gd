extends RigidBody2D
var max_velocity = 50
var is_grabbed: bool = false
var in_levitate = false
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@export var block_type: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if in_levitate:
		linear_velocity*=-1.0
	if linear_velocity.x>max_velocity:
		linear_velocity.x=max_velocity
	if linear_velocity.x<-max_velocity:
		linear_velocity.x=-max_velocity
	

func jumping():
	linear_velocity.y = -500
func break_it():
	var collider = $RayCast2D.get_collider()
	if collider != null and collider.is_in_group("block"):
		collider.sleeping = false
	$CollisionShape2D.disabled = true
	await get_tree().physics_frame
	queue_free()

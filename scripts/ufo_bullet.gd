extends CharacterBody2D

var speed = 400
var direction = Vector2.ZERO
var target = Vector2.ZERO

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ufo_bullet: CharacterBody2D = $"."
@onready var player: CharacterBody2D = $"../Player"
@onready var line_2d: Line2D = $Line2D

func _ready() -> void:
	target = player.position
	ray_cast_2d.look_at(target)
	print(ray_cast_2d.rotation)
	ufo_bullet.rotation = ray_cast_2d.rotation


func _physics_process(delta: float) -> void:
	
	position = position.move_toward(target, speed * delta)
	
	# this returns some info about the object the ball collides with but I don't understand it fully yet
	var collision = move_and_collide(velocity * delta)
	
		# check to see if a collision occurred
	if collision:
		#print("Collision")
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()
			ufo_bullet.queue_free()
	
	await get_tree().create_timer(2).timeout
	ufo_bullet.queue_free()

func lookAtPlayer():
	ufo_bullet.look_at(player.position)
	print(player.position)

extends CharacterBody2D



var speed = 100
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var game: Node2D = $".."
@onready var medium_asteroid: CharacterBody2D = $"."
@onready var smallAsteroidObject = preload("res://scenes/small_asteroid.tscn")



func _ready() -> void:
	ray_cast_2d.target_position = Vector2(randf_range(-5,5), randf_range(-5,5))


func _physics_process(delta: float) -> void:
	var target = to_global(ray_cast_2d.target_position)
	position = position.move_toward(target, speed * delta)
	
	# this returns some info about the object the ball collides with but I don't understand it fully yet
	var collision = move_and_collide(velocity * delta)
	
		# check to see if a collision occurred
	if collision:
		#print("Collision")
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()
			hit()
			medium_asteroid.queue_free()
	
func hit():
	var n = 2
	for i in n:
		#print("New Small Asteroid")
		var newSmAsteroid = smallAsteroidObject.instantiate()
		#print(newSmAsteroid)
		newSmAsteroid.position = medium_asteroid.position
		game.add_child(newSmAsteroid)
		
	queue_free()

extends CharacterBody2D

var randNumX = randf_range(0, 960)
var randNumY = randf_range(0,540)
var speed = 100
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var mediumAsteroidObject = preload("res://scenes/medium_asteroid.tscn")
@onready var game: Node2D = $".."
@onready var large_asteroid: CharacterBody2D = $"."

func _ready() -> void:
	#await get_tree().create_timer(2).timeout
	#randomizeStartPosition()
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
			large_asteroid.queue_free()
			
	
func randomizeStartPosition():
	position = Vector2(randNumX, randNumY)


func hit():
	Global.score += 20
	Global.numOfAsteroids -= 1
	var n = 3
	for i in n:
		Global.numOfAsteroids += 1
		#print("New Med Asteroid")
		var newMedAsteroid = mediumAsteroidObject.instantiate()
		newMedAsteroid.position = large_asteroid.position
		
		game.add_child(newMedAsteroid)
		
		
	queue_free()
	

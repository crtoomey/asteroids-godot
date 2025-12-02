extends CharacterBody2D

var speed = 100

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var small_asteroid: CharacterBody2D = $"."
@onready var explosion_particles: GPUParticles2D = $ExplosionParticles
@onready var line_2d: Line2D = $Line2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D


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
			small_asteroid.queue_free()

func hit():
	var randNum = randi_range(1,10)
	if randNum <= 2 and Global.life < 3:
		Global.life += 1
		explosion_particles.process_material.color = Color(1.0, 0.712, 0.915, 1.0)
		print("Life Gained")
	else:
		explosion_particles.process_material.color = Color.WHITE
	Global.numOfAsteroids -= 1
	explosion_particles.emitting = true
	line_2d.visible = false
	collision_polygon_2d.disabled = true
	Global.score += 100
	await get_tree().create_timer(.5).timeout
	queue_free()

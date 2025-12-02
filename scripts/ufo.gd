extends CharacterBody2D

var speed = 200
var dir = 1
var topLeftSpawn = false
var topRightSpawn = false
var bottomRightSpawn = false
var bottomLeftSpawn = false
@onready var ufoBulletObject = preload("res://scenes/ufo_bullet.tscn")
@onready var shotgunObject = preload("res://scenes/shotgun.tscn")
@onready var shieldObject = preload("res://scenes/shield.tscn")
@onready var game: Node2D = $".."
@onready var player: CharacterBody2D = $"../Player"
@onready var bullet_timer: Timer = $BulletTimer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var explosion_particles: GPUParticles2D = $ExplosionParticles
@onready var line_2d: Line2D = $Line2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var ufo: CharacterBody2D = $"."

func _ready() -> void:
	#print("UFO Spawned")
	bullet_timer.wait_time = 2
	bullet_timer.start()
	#print(position)

func _physics_process(delta: float) -> void:
	
	if position == Vector2(-100, 100):
		topLeftSpawn = true
		#print("UFO Moving")
		#position = position.move_toward(Vector2(200, 200), speed * delta)
		#print(position)
	elif position == Vector2(1060, 100):
		topRightSpawn = true
		#print("UFO Moving")
		#position = position.move_toward(Vector2(760, 200), speed * delta)
		print(position)
	elif position == Vector2(1060, 440):
		bottomRightSpawn = true
		#print("UFO Moving")
		#position = position.move_toward(Vector2(760, 340), speed * delta)
		#print(position)
	elif position == Vector2(-100, 440):
		bottomLeftSpawn = true
		#print("UFO Moving")
		#position = position.move_toward(Vector2(200, 340), speed * delta)
		#print(position)
		
		
	if topLeftSpawn == true:
		position = position.move_toward(Vector2(200, 200), speed * delta)
		#print(position)
	elif topRightSpawn == true:
		position = position.move_toward(Vector2(760, 200), speed * delta)
		#print(position)
	elif bottomRightSpawn:
		position = position.move_toward(Vector2(760, 340), speed * delta)
		#print(position)
	elif bottomLeftSpawn == true:
		position = position.move_toward(Vector2(200, 340), speed * delta)
		#print(position)
	
	await get_tree().create_timer(10).timeout
	position.x += dir * speed * delta
	position.y += dir * speed * delta
	await get_tree().create_timer(5).timeout
	queue_free()

func hit():
	var randNum = randi_range(1,10)
	if randNum <= 3:
		print("Shotgun dropped")
		var newShotgun = shotgunObject.instantiate()
		newShotgun.position = ufo.position
		game.add_child(newShotgun)
	elif randNum > 3 and randNum >= 5:
		print("Shield dropped")
		var newShield = shieldObject.instantiate()
		newShield.position = ufo.position
		game.add_child(newShield)
	else:
		print("Nothing dropped")
	explosion_particles.emitting = true
	line_2d.visible = false
	collision_polygon_2d.disabled = true
	Global.score += 500
	await get_tree().create_timer(.5).timeout
	queue_free()

func makeBullet():
	#print("Shoot")
	var newBullet = ufoBulletObject.instantiate()
	game.add_child(newBullet)
	newBullet.position = position
	
	return newBullet

func isUFO():
	pass


func _on_bullet_timer_timeout() -> void:
	makeBullet()
	bullet_timer.wait_time = 2
	bullet_timer.start()

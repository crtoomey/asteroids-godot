extends CharacterBody2D

var speed = 200
var dir = 1
var topLeftSpawn = false
var topRightSpawn = false
var bottomRightSpawn = false
var bottomLeftSpawn = false
@onready var ufoBulletObject = preload("res://scenes/ufo_bullet.tscn")
@onready var game: Node2D = $".."
@onready var player: CharacterBody2D = $"../Player"
@onready var bullet_timer: Timer = $BulletTimer

func _ready() -> void:
	print("UFO Spawned")
	bullet_timer.wait_time = 2
	bullet_timer.start()
	#print(position)

func _physics_process(delta: float) -> void:
	if position == Vector2(-100, 100):
		topLeftSpawn = true
		print("UFO Moving")
		#position = position.move_toward(Vector2(200, 200), speed * delta)
		print(position)
	elif position == Vector2(1060, 100):
		topRightSpawn = true
		print("UFO Moving")
		#position = position.move_toward(Vector2(760, 200), speed * delta)
		print(position)
	elif position == Vector2(1060, 440):
		bottomRightSpawn = true
		print("UFO Moving")
		#position = position.move_toward(Vector2(760, 340), speed * delta)
		print(position)
	elif position == Vector2(-100, 440):
		bottomLeftSpawn = true
		print("UFO Moving")
		#position = position.move_toward(Vector2(200, 340), speed * delta)
		print(position)
		
		
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

func hit():
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

extends CharacterBody2D

var direction = 0
var speed = 400

@onready var line_2d: Line2D = $Line2D
@onready var engine_lines: Line2D = $EngineLines
@onready var player: CharacterBody2D = $"."
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var bulletObject = preload("res://scenes/player_bullet.tscn")
@onready var game: Node2D = $".."
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var health_ui: Node2D = $"../HealthUI"
@onready var travel_line: Line2D = $"../TravelLine"
@onready var fire: AudioStreamPlayer2D = $Fire
@onready var warp_sound: AudioStreamPlayer2D = $WarpSound
@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound


func _ready() -> void:
	# turn off collision for 1 sec after loading in to avoid losing life immediately
	collision_polygon_2d.disabled = true
	await get_tree().create_timer(1).timeout
	collision_polygon_2d.disabled = false

func _physics_process(delta: float) -> void:
	
	engine_lines.visible = false
	
	# movement stuff
	if Input.is_action_pressed("move_forward"):
		engine_lines.visible = true
		
		var target = to_global(ray_cast_2d.target_position)
		
		#print(target)
		position = position.move_toward(target, speed * delta)
		
	if Input.is_action_pressed("move_left"):
		player.rotation_degrees -= 5
	if Input.is_action_pressed("move_right"):
		player.rotation_degrees += 5
	
	# shooting
	if Input.is_action_just_pressed("fire"):
		fire.play()
		makeBullet()
	
	# turn off collision after warping to random location and slow down time
	if Input.is_action_just_pressed("warp"):
		warp_sound.play()
		var randX = randf_range(0, 960)
		var randY = randf_range(0, 540)
		var prevPos = player.position
		travel_line.default_color = Color(0.954, 0.863, 0.0, 1.0)
		travel_line.width = 1
		line_2d.default_color = Color(0.954, 0.863, 0.0, 1.0)
		print(prevPos)
		travel_line.add_point(prevPos)
		travel_line.add_point(Vector2(randX, randY))
		position = Vector2(randX, randY)
		print(position)
		collision_polygon_2d.disabled = true
		Engine.time_scale = .5
		await get_tree().create_timer(.5).timeout
		travel_line.clear_points()
		line_2d.default_color = Color(1.0, 1.0, 1.0, 1.0)
		Engine.time_scale = 1
		collision_polygon_2d.disabled = false
	
	# pickup timers
	if Global.hasShotgun == true:
		await get_tree().create_timer(15).timeout
		Global.hasShotgun = false
		
	if Global.hasShield == true:
		var healthIconOne = health_ui.get_child(0)
		var healthIconTwo = health_ui.get_child(1)
		var healthIconThree = health_ui.get_child(2)
		line_2d.default_color = Color(0.288, 0.742, 1.0, 1.0)
		healthIconOne.default_color = Color(0.288, 0.742, 1.0, 1.0)
		healthIconTwo.default_color = Color(0.288, 0.742, 1.0, 1.0)
		healthIconThree.default_color = Color(0.288, 0.742, 1.0, 1.0)
		collision_polygon_2d.disabled = true
		await get_tree().create_timer(7).timeout
		collision_polygon_2d.disabled = false
		line_2d.default_color = Color(1.0, 1.0, 1.0, 1.0)
		healthIconOne.default_color = Color(1.0, 1.0, 1.0, 1.0)
		healthIconTwo.default_color = Color(1.0, 1.0, 1.0, 1.0)
		healthIconThree.default_color = Color(1.0, 1.0, 1.0, 1.0)
		Global.hasShield = false
	
	
func makeBullet():
	#print("Shoot")	
	
	# Shotgun Bullets
	if Global.hasShotgun == true:
		for i in 3:
			#print(i)
			var newBullet = bulletObject.instantiate()
			game.add_child(newBullet)
			newBullet.position = position
			if i == 0:
				newBullet.rotation_degrees = player.rotation_degrees
			elif i == 1:
				newBullet.rotation_degrees = player.rotation_degrees + 15
			elif i == 2:
				newBullet.rotation_degrees = player.rotation_degrees - 15
	# Regular Bullet
	else:
		var newBullet = bulletObject.instantiate()
		game.add_child(newBullet)
		newBullet.position = position
		newBullet.rotation_degrees = player.rotation_degrees



func hit():
	explosion_sound.play()
	Global.life -= 1
	#print("Lost life")
	collision_polygon_2d.disabled = true
	line_2d.visible = false
	await get_tree().create_timer(.1).timeout
	line_2d.visible = true
	await get_tree().create_timer(.1).timeout
	line_2d.visible = false
	await get_tree().create_timer(.1).timeout
	line_2d.visible = true
	await get_tree().create_timer(.5).timeout
	collision_polygon_2d.disabled = false

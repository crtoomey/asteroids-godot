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


func _physics_process(delta: float) -> void:
	
	engine_lines.visible = false
	
	if Input.is_action_pressed("move_forward"):
		engine_lines.visible = true
		var target = to_global(ray_cast_2d.target_position)
		
		#print(target)
		position = position.move_toward(target, speed * delta)
		
	if Input.is_action_pressed("move_left"):
		player.rotation_degrees -= 2
	if Input.is_action_pressed("move_right"):
		player.rotation_degrees += 2
	
	if Input.is_action_just_pressed("fire"):
		makeBullet()
	
	
func makeBullet():
	#print("Shoot")
	var newBullet = bulletObject.instantiate()
	game.add_child(newBullet)
	newBullet.position = position
	newBullet.rotation_degrees = player.rotation_degrees
	return newBullet


func hit():
	print("Lost life")
	collision_polygon_2d.disabled = true
	line_2d.visible = false
	await get_tree().create_timer(.1).timeout
	line_2d.visible = true
	await get_tree().create_timer(.1).timeout
	line_2d.visible = false
	await get_tree().create_timer(.1).timeout
	line_2d.visible = true
	collision_polygon_2d.disabled = false

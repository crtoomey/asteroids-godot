extends CharacterBody2D


var randNumX = randf_range(0, 960)
var randNumY = randf_range(0,540)
var speed = 100
@onready var ray_cast_2d: RayCast2D = $RayCast2D



func _ready() -> void:
	randomizeStartPosition()
	ray_cast_2d.target_position = Vector2(randf_range(-5,5), randf_range(-5,5))


func _physics_process(delta: float) -> void:
	var target = to_global(ray_cast_2d.target_position)
	position = position.move_toward(target, speed * delta)
	
func randomizeStartPosition():
	position = Vector2(randNumX, randNumY)

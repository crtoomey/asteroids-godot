extends StaticBody2D

var speed = 400

@onready var ray_cast_2d: RayCast2D = $RayCast2D


func _physics_process(delta: float) -> void:
	var target = to_global(ray_cast_2d.target_position)
	position = position.move_toward(target, speed * delta)
	

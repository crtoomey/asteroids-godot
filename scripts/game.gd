extends Node2D

var screenWidth = 960
var screenHeight = 540
var randNumOfAsteroids = randi_range(3, 10)
@onready var largeAsteroidObject = preload("res://scenes/large_asteroid.tscn")
#@onready var mediumAsteroidObject = preload("res://scenes/medium_asteroid.tscn")
#@onready var smallAsteroidObject = preload("res://scenes/small_asteroid.tscn")
@onready var game: Node2D = $"."

func _ready() -> void:
	loadLevel()
		

func loadLevel():
	#print(randNumOfAsteroids)
	for n in randNumOfAsteroids:
		var randNumX = randf_range(0, 960)
		var randNumY = randf_range(0,540)
		var newAsteroid = largeAsteroidObject.instantiate()
		newAsteroid.position = Vector2(randNumX, randNumY)
		game.add_child(newAsteroid)
		#print("New Asteroid spawned")

func _on_top_body_entered(body: Node2D) -> void:
	
	body.position.y = body.position.y + screenHeight


func _on_bottom_body_entered(body: Node2D) -> void:
	body.position.y = body.position.y - screenHeight


func _on_left_body_entered(body: Node2D) -> void:
	body.position.x = body.position.x + screenWidth


func _on_right_body_entered(body: Node2D) -> void:
	body.position.x = body.position.x - screenWidth

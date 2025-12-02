extends Node2D

var screenWidth = 960
var screenHeight = 540
var randNumOfAsteroids = randi_range(3, 10)
var randNum = randf_range(10,30)
@onready var largeAsteroidObject = preload("res://scenes/large_asteroid.tscn")
#@onready var mediumAsteroidObject = preload("res://scenes/medium_asteroid.tscn")
#@onready var smallAsteroidObject = preload("res://scenes/small_asteroid.tscn")
@onready var game: Node2D = $"."
@onready var ufo_timer: Timer = $UFOTimer
@onready var ufoObject = preload("res://scenes/ufo.tscn")


func _ready() -> void:
	loadLevel()
	ufo_timer.wait_time = randNum
	ufo_timer.start()

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
	if body.has_method("isUFO"):
		pass
	else:
		body.position.y = body.position.y + screenHeight


func _on_bottom_body_entered(body: Node2D) -> void:
	if body.has_method("isUFO"):
		pass
	else:
		body.position.y = body.position.y - screenHeight


func _on_left_body_entered(body: Node2D) -> void:
	if body.name != "ufo":
		body.position.x = body.position.x + screenWidth


func _on_right_body_entered(body: Node2D) -> void:
	if body.name != "ufo":
		body.position.x = body.position.x - screenWidth

func makeUFO():
	var randDir =randi_range(1,4)
	var newUFO = ufoObject.instantiate()
	#newUFO.position = Vector2(480, -200)
	#print(newUFO)
	##top left spawn
	if randDir == 1:
		newUFO.global_position = Vector2(-100, 100)
		#newUFO.postion.x = -100
		#newUFO.postion.y = 100
		print("top left")
	#top right spawn
	elif randDir == 2:
		newUFO.global_position = Vector2(1060, 100)
		#newUFO.postion.x = 1060
		#newUFO.postion.y = 100
		print("top right")
	#bottom right spawn
	elif randDir == 3:
		newUFO.global_position = Vector2(1060, 440)
		#newUFO.postion.x = 1060
		#newUFO.postion.y = 440
		print("bottom right")
	#bottom left spawn
	elif randDir == 4:
		newUFO.global_position = Vector2(-100, 440)
		#newUFO.postion.x = -100
		#newUFO.postion.y = 440
		print("bottom left")
	game.add_child(newUFO)
	

func _on_ufo_timer_timeout() -> void:
	makeUFO()
	randNum = randf_range(20,50)
	# reset timer
	ufo_timer.wait_time = randNum
	ufo_timer.start()

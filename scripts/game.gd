extends Node2D

var screenWidth = 960
var screenHeight = 540
var randNumOfAsteroids = randi_range(3, 10)
var randNum = randf_range(10,30)
var healthArray = []
@onready var largeAsteroidObject = preload("res://scenes/large_asteroid.tscn")
@onready var game: Node2D = $"."
@onready var ufo_timer: Timer = $UFOTimer
@onready var ufoObject = preload("res://scenes/ufo.tscn")
@onready var health_ui: Node2D = $HealthUI
@onready var healthObject = preload("res://scenes/health.tscn")
@onready var score_label: Label = $ScoreLabel
@onready var pauseScene = preload("res://scenes/pause_menu.tscn")

func _ready() -> void:
	loadHealthUI()
	loadLevel()
	ufo_timer.wait_time = randNum
	ufo_timer.start()

func _process(_delta: float) -> void:
	# set score
	score_label.text = str(Global.score)
	# health logic
	if Global.life == 3:
		var nodeThree = healthArray[2]
		var nodeTwo = healthArray[1]
		var nodeOne = healthArray[0]
		nodeOne.visible = true
		nodeTwo.visible = true
		nodeThree.visible = true
	elif Global.life == 2:
		var nodeThree = healthArray[2]
		var nodeTwo = healthArray[1]
		var nodeOne = healthArray[0]
		nodeOne.visible = true
		nodeTwo.visible = true
		nodeThree.visible = false
	elif Global.life == 1:
		var nodeThree = healthArray[2]
		var nodeTwo = healthArray[1]
		var nodeOne = healthArray[0]
		nodeOne.visible = true
		nodeTwo.visible = false
		nodeThree.visible = false
	elif Global.life == 0:
		var nodeThree = healthArray[2]
		var nodeTwo = healthArray[1]
		var nodeOne = healthArray[0]
		nodeOne.visible = true
		nodeTwo.visible = false
		nodeThree.visible = false
		Global.gameOver()
		
		
	# pause menu
	if Input.is_action_just_pressed("pause"):
		Engine.time_scale = 0
		var pauseMenu = pauseScene.instantiate()
		pauseMenu.position = Vector2(0,0)
		add_child(pauseMenu)

		
	# check if there are no asteroids left
	if Global.numOfAsteroids == 0:
		newRound()
		

func loadLevel():
	#print(randNumOfAsteroids)
	for n in randNumOfAsteroids:
		var randNumX = randf_range(0, 960)
		var randNumY = randf_range(0,540)
		var newAsteroid = largeAsteroidObject.instantiate()
		newAsteroid.position = Vector2(randNumX, randNumY)
		game.add_child(newAsteroid)
		Global.numOfAsteroids += 1
		#print("New Asteroid spawned")

func newRound():
	randNumOfAsteroids = randi_range(5, 10)

	#print(randNumOfAsteroids)
	for n in randNumOfAsteroids:
		var randNumX = randf_range(0, 960)
		var randNumY = randf_range(0,540)
		var newAsteroid = largeAsteroidObject.instantiate()
		newAsteroid.position = Vector2(randNumX, randNumY)
		game.add_child(newAsteroid)
		Global.numOfAsteroids += 1
		#print("New Asteroid spawned")

func loadHealthUI():
	#add health icons at the start of the round, there should be 3
	for i in 4:
		if i == 1:
			var newHealth = healthObject.instantiate()
			healthArray.append(newHealth)
			#print(i)
			newHealth.position = Vector2(20,30)
			health_ui.add_child(newHealth)
		elif i == 2:
			var newHealth = healthObject.instantiate()
			healthArray.append(newHealth)
			#print(i)
			newHealth.position = Vector2(40,30)
			health_ui.add_child(newHealth)
		elif i == 3:
			var newHealth = healthObject.instantiate()
			healthArray.append(newHealth)
			#print(i)
			newHealth.position = Vector2(60,30)
			health_ui.add_child(newHealth)
		#print(healthArray)

func _on_top_body_entered(body: Node2D) -> void:
	if body.has_method("isUFO") == true:
		pass
	else:
		body.position.y = body.position.y + screenHeight


func _on_bottom_body_entered(body: Node2D) -> void:
	if body.has_method("isUFO") == true:
		pass
	else:
		body.position.y = body.position.y - screenHeight


func _on_left_body_entered(body: Node2D) -> void:
	if body.has_method("isUFO") == true:
		pass
	else:
		body.position.x = body.position.x + screenWidth


func _on_right_body_entered(body: Node2D) -> void:
	if body.has_method("isUFO") == true:
		pass
	else:
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

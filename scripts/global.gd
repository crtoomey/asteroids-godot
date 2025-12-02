extends Node

var life = 3
var score = 0
var highScore = 0
var numOfAsteroids = 0
var hasShotgun = false
var hasShield = false
@onready var gameScene = preload("res://scenes/game.tscn")

func gameOver():
	#print("game over")
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
	await get_tree().create_timer(1).timeout
	life = 3
	score = 0
	numOfAsteroids = 0

func getHighScore(newScore):
	print(newScore)
	if newScore >= highScore:
		highScore = newScore
		#print(highScore)
	else:
		highScore = highScore

extends Node2D

var screenWidth = 960
var screenHeight = 540
@onready var largeAsteroidObject = preload("res://scenes/large_asteroid.tscn")
@onready var click_sound: AudioStreamPlayer2D = $ClickSound

func _ready() -> void:
	loadMenu()
	

func loadMenu():
	for n in 10:
		var randNumX = randf_range(0, 960)
		var randNumY = randf_range(0,540)
		var newAsteroid = largeAsteroidObject.instantiate()
		newAsteroid.position = Vector2(randNumX, randNumY)
		add_child(newAsteroid)


func _on_top_body_entered(body: Node2D) -> void:
	body.position.y = body.position.y + screenHeight


func _on_bottom_body_entered(body: Node2D) -> void:
	body.position.y = body.position.y - screenHeight


func _on_left_body_entered(body: Node2D) -> void:
	body.position.x = body.position.x + screenWidth


func _on_right_body_entered(body: Node2D) -> void:
	body.position.x = body.position.x - screenWidth


func _on_start_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(.2).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")

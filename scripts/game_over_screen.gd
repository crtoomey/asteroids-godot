extends Node2D
@onready var score_label: Label = $Sprite2D/ScoreLabel
@onready var your_score_label: Label = $Sprite2D/YourScoreLabel
@onready var highscore_label: Label = $Sprite2D/HighscoreLabel
@onready var your_highscore_label: Label = $Sprite2D/YourHighscoreLabel
@onready var click_sound: AudioStreamPlayer2D = $Sprite2D/ClickSound

func _ready() -> void:
	Global.getHighScore(Global.score)
	score_label.text = str(Global.score)
	highscore_label.text = str(Global.highScore)


func _on_restart_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(.2).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_main_menu_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(.2).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

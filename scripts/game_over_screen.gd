extends Node2D
@onready var score_label: Label = $Sprite2D/ScoreLabel
@onready var your_score_label: Label = $Sprite2D/YourScoreLabel
@onready var highscore_label: Label = $Sprite2D/HighscoreLabel
@onready var your_highscore_label: Label = $Sprite2D/YourHighscoreLabel

func _ready() -> void:
	Global.getHighScore(Global.score)
	score_label.text = str(Global.score)
	highscore_label.text = str(Global.highScore)


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

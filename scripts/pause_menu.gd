extends Node2D
@onready var pause_menu: Node2D = $"."
@onready var color_rect: ColorRect = $ColorRect
@onready var score_label: Label = $ColorRect/ScoreLabel
@onready var highscore_label: Label = $ColorRect/HighscoreLabel
@onready var click_sound: AudioStreamPlayer2D = $ClickSound

func _ready() -> void:
	Global.getHighScore(Global.score)
	score_label.text = str(Global.score)
	highscore_label.text = str(Global.highScore)

func _on_resume_button_pressed() -> void:
	click_sound.play()
	Engine.time_scale = 1
	await get_tree().create_timer(.2).timeout
	pause_menu.queue_free()

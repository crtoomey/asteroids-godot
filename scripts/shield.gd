extends StaticBody2D

@onready var shield_sound: AudioStreamPlayer2D = $ShieldSound
@onready var shield: StaticBody2D = $"."


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		shield.visible = false
		Global.hasShield = true
		shield_sound.play()
		await get_tree().create_timer(.5).timeout
		queue_free()

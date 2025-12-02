extends StaticBody2D
@onready var shotgun_sound: AudioStreamPlayer2D = $ShotgunSound
@onready var shotgun: StaticBody2D = $"."


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		shotgun.visible = false
		shotgun_sound.play()
		Global.hasShotgun = true
		await get_tree().create_timer(.7).timeout
		queue_free()

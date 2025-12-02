extends StaticBody2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hasShield = true
		await get_tree().create_timer(.1).timeout
		queue_free()

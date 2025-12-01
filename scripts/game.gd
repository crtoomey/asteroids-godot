extends Node2D

var screenWidth = 960
var screenHeight = 540

	


func _on_top_body_entered(body: Node2D) -> void:
	
	body.position.y = body.position.y + screenHeight


func _on_bottom_body_entered(body: Node2D) -> void:
	body.position.y = body.position.y - screenHeight


func _on_left_body_entered(body: Node2D) -> void:
	body.position.x = body.position.x + screenWidth


func _on_right_body_entered(body: Node2D) -> void:
	body.position.x = body.position.x - screenWidth

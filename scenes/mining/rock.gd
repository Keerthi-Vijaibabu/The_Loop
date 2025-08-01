extends Area2D

func _on_body_entered(body):
	if body.name == "Mining_Player":
		get_tree().call_group("game", "new_game")
		queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

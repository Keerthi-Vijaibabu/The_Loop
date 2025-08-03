extends Area2D

func _on_stone_body_entered(body):
	if body.name == "Mining_Player":
		print("Stone collected")
		get_tree().call_group("game", "add_stone", 1)
		queue_free() 

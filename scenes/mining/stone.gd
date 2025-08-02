extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Mining_Player":
		get_tree().call_group("game", "add_stone", 1)
		queue_free()  # Remove coin

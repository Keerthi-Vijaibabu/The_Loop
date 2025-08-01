extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body):
	if body.name == "Mining_Player":
		get_tree().call_group("game", "add_gold", 1)
		queue_free()  # Remove coin

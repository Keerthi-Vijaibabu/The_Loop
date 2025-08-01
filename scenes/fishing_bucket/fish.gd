extends CharacterBody2D

const GRAVITY = 75.0

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var ScoreManager = get_tree().get_root().get_node("Fishing/ScoreManager")
		ScoreManager.add_point()
		queue_free()

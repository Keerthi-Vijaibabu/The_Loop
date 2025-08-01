extends CharacterBody2D

const GRAVITY = 120.0

func _physics_process(_delta):
	velocity.y += GRAVITY * _delta
	move_and_slide()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var ScoreManager = get_node("/root/Lumberjack/Scoremanager") # adjust if needed
		ScoreManager.add_point()
		queue_free()

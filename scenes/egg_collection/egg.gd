extends CharacterBody2D

const GRAVITY = 9.0  

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()

func _input_event(viewport, event, shape_idx): # Destroys the object when clicked
	if event is InputEventMouseButton and event.pressed:
		var ScoreManager =get_tree().get_root().get_node("EggCollection/ScoreManager")
		ScoreManager.add_point()
		queue_free()  

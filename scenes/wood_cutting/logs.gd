extends CharacterBody2D

const GRAVITY = 98.0  

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()

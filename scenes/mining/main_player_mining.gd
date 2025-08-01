extends CharacterBody2D

const Gravity = 4200
const JUMP_SPEED = -1800

func _physics_process(delta):
	velocity.y += Gravity*delta
	if Input.is_action_pressed("ui_accept"):
		velocity.y = JUMP_SPEED
		$JumpSound.play()
		
	move_and_slide()

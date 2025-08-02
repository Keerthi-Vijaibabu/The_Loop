extends CharacterBody2D

@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

const GRAVITY = 4200
const JUMP_SPEED = -1000
const MOVE_SPEED = 200  
func _physics_process(delta):
	
	velocity.y += GRAVITY * delta
	velocity.x = MOVE_SPEED
	
	if is_on_floor():
		if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_up"):
			velocity.y = JUMP_SPEED
			jump_sound.play()
	else:
		$AnimatedSprite2D.play("jump")

	move_and_slide()

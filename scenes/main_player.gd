extends CharacterBody2D

const SPEED = 300.0
const ACCEL = 2.0

var input: Vector2

@onready var sprite = $AnimatedSprite2D

func get_input():
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input.normalized()
	
func _process(delta):
		
	var playerInput = get_input()
		
	velocity = lerp(velocity, playerInput*SPEED, delta*ACCEL)
	
	move_and_slide()
		
	update_animation(playerInput)

func update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		sprite.stop()
		return

	if abs(direction.x) > abs(direction.y):
		
		sprite.animation = "right" if direction.x > 0 else "left"
	else:
		
		sprite.animation = "front" if direction.y > 0 else "back"

	sprite.play()

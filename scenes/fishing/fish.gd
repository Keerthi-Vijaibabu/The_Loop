extends CharacterBody2D

@export var speed := 150.0  
func _ready():
	
	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.play("swim")
	
	
	if has_node("Bubbles"):
		$Bubbles.emitting = true

func _physics_process(delta):
	velocity.x = speed
	move_and_slide()

	
	if position.x > 1200:  
		queue_free()

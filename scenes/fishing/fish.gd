extends CharacterBody2D

@export var base_speed := 100
var speed_multiplier := 1.0
var _score_manager = null

func _ready():
	$Sprite2D.flip_h = true
	input_pickable = true

func set_score_manager(manager):
	_score_manager = manager
	print("✅ ScoreManager set:", _score_manager)

func _physics_process(_delta):
	velocity.x = base_speed * speed_multiplier
	move_and_slide()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("🎯 Fish clicked!")
		if _score_manager:
			_score_manager.add_point()
		queue_free()

func _process(_delta):
	if position.x > get_viewport_rect().size.x + 100:
		queue_free()

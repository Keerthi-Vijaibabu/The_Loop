extends Node2D

@export var spawn_object: PackedScene = preload("res://scenes/fishing/fish.tscn")
@export var spawn_number: int = 20

var random = RandomNumberGenerator.new()

func _ready():
	spawn_fishes()

func get_random_y_position() -> float:
	random.randomize()
	return random.randf_range(300.0, 500.0)  

func spawn_fishes():
	for i in range(spawn_number):
		await get_tree().create_timer(random.randf_range(0.5, 2.0)).timeout
		var fish = spawn_object.instantiate()
		fish.position = Vector2(-200, get_random_y_position())  

		var should_flip = random.randf() < 0.5
		if should_flip:
			fish.scale.x *= -1

		if fish.has_variable("speed"):
			fish.speed = random.randf_range(100.0, 200.0)

		if fish.has_node("AnimatedSprite2D"):
			var tint = Color(1, random.randf_range(0.7, 1.0), random.randf_range(0.7, 1.0))
			fish.get_node("AnimatedSprite2D").modulate = tint
		elif fish.has_node("Sprite2D"):
			var tint = Color(1, random.randf_range(0.7, 1.0), random.randf_range(0.7, 1.0))
			fish.get_node("Sprite2D").modulate = tint

		add_child(fish)

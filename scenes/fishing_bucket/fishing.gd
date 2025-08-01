extends Node2D

@export var spawn_object: PackedScene = preload("res://scenes/fishing_bucket/fish.tscn")
@export var spawn_number = 30

var random = RandomNumberGenerator.new()

func _ready():
	spawn()

func get_random_position(screen_width: float) -> Vector2:
	random.randomize()
	var x = random.randf_range(-abs(screen_width / 2), abs(screen_width / 2))
	var y = -2000
	return Vector2(x, y)

func spawn():
	for i in range(spawn_number):
		await get_tree().create_timer(1).timeout
		var obj = spawn_object.instantiate()
		obj.position = get_random_position(1024)
		add_child(obj)

extends Node2D

@export var spawn_object: PackedScene = preload("res://scenes/wood_cutting/logs.tscn")

@export var spawn_number = 50

var random = RandomNumberGenerator.new()

func _ready():
	spawn()
	
func getRandomPosition(size) -> Vector2:
	random.randomize()
	var x = random.randf_range(-abs(size/2), abs(size/2))
	var y = -2000  #gives me some time for the narration box before the objects start to fall
	return Vector2(x,y)
	
func spawn():
	for i in range(spawn_number):
		await get_tree().create_timer(1).timeout 
		var obj = spawn_object.instantiate()
		obj.position = getRandomPosition(1024)
		add_child(obj)

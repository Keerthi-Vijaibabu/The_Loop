extends Node2D

@export var spawn_object: PackedScene = preload("res://scenes/fishing/fish.tscn")
@export var spawn_number: int = 50
@export var game_duration: float = 30.0
@export var target_score: int = 10

var rng = RandomNumberGenerator.new()
var score_manager
var timer: Timer

func _ready():
	score_manager = get_node("ScoreManager")
	var score_label = get_node("ScoreLabel")
	score_manager.score_label = score_label
	start_game()

func _process(_delta: float) -> void:
	$TimerLabel.text = "TIME: %d" % int($Timer.time_left)

func start_game():
	score_manager.reset_score()
	start_timer()
	await spawn_fish() 

func start_timer():
	$Timer.wait_time = game_duration
	$Timer.one_shot = true
	$Timer.connect("timeout", Callable(self, "_on_game_timeout"))
	$Timer.start()

func get_spawn_position(screen_size: Vector2) -> Vector2:
	rng.randomize()
	var y = rng.randf_range(100, screen_size.y - 200)
	return Vector2(-200, y)

func spawn_fish() -> void:
	var screen_size = get_viewport_rect().size
	for i in range(spawn_number):
		var delay = rng.randf_range(0.3, 1.2)
		await get_tree().create_timer(delay).timeout

		var fish = spawn_object.instantiate()
		if fish.has_method("set_score_manager"):
			fish.set_score_manager(score_manager)
		fish.scale = Vector2(0.5, 0.5)
		fish.speed_multiplier = 1.5
		fish.position = get_spawn_position(screen_size)

		add_child(fish)

func _on_game_timeout() -> void:
	if score_manager.score >= target_score:
		GlobalSceneManager.fish = score_manager.score
		GlobalSceneManager.curr_points = score_manager.score * 20
	else:
		GlobalSceneManager.fish = score_manager.score
		GlobalSceneManager.curr_points = score_manager.score * 2

	get_tree().change_scene_to_file("res://scenes/go_fishing.tscn")

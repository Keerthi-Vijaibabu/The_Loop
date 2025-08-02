extends Node2D

@export var spawn_object: PackedScene = preload("res://scenes/fishing/fish.tscn")
@export var spawn_number := 30
@export var game_duration := 30
@export var target_score := 10

var rng = RandomNumberGenerator.new()
var score_manager
var timer

func _ready():
	score_manager = get_node("ScoreManager")
	var score_label = get_node("ScoreLabel")
	score_manager.score_label = score_label
	start_game()


func start_game():
	score_manager.reset_score()
	start_timer()
	spawn_fish()

func start_timer():
	timer = Timer.new()
	timer.wait_time = game_duration
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_game_timeout"))
	add_child(timer)
	timer.start()

func get_spawn_position(screen_size) -> Vector2:
	rng.randomize()
	var y = rng.randf_range(100, screen_size.y - 200)
	return Vector2(-200, y)

func spawn_fish():
	var screen_size = get_viewport_rect().size
	for i in range(spawn_number):
		var delay = rng.randf_range(0.3, 1.2)
		await get_tree().create_timer(delay).timeout

		var fish = spawn_object.instantiate()
		fish.set_score_manager(score_manager)
		fish.scale = Vector2(0.5, 0.5)
		fish.speed_multiplier = 1.5
		fish.position = get_spawn_position(screen_size)

		add_child(fish)

func _on_game_timeout():
	if score_manager.score >= target_score:
		show_message("🎉 You Win!")
	else:
		show_message("😢 You Lose. Try Again!")

	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()

func show_message(text):
	var label = get_node("MessageLabel")
	label.text = text
	label.visible = true

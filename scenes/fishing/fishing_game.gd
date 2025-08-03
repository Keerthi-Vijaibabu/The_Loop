extends Node2D

@export var spawn_object: PackedScene = preload("res://scenes/fishing/fish.tscn")
@export var spawn_number := 150
@export var game_duration := 30        
@export var target_score := 20

var rng = RandomNumberGenerator.new()
var score_manager
var timer
var game_ended := false

func _ready():
	score_manager = get_node("ScoreManager")
	var score_label = get_node("ScoreLabel")
	score_manager.score_label = score_label
	start_game()

	# Set background to fullscreen
	var sprite = get_node("Background/Area2D/Sprite2D")
	if sprite and sprite.texture:
		var screen_size = get_viewport_rect().size
		var tex_size = sprite.texture.get_size()
		sprite.scale = screen_size / tex_size
	else:
		print("❌ Sprite2D or its texture not found!")


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
		if game_ended:
			return  # Stop spawning if game has ended

		var delay = rng.randf_range(0.2, 1.0)
		await get_tree().create_timer(delay).timeout

		if game_ended:
			return  # Double-check again after delay

		var fish = spawn_object.instantiate()
		fish.set_score_manager(score_manager)
		fish.scale = Vector2(0.5, 0.5)
		fish.speed_multiplier = 5.5
		fish.position = get_spawn_position(screen_size)

		add_child(fish)

func _on_game_timeout():
	if game_ended:
		return
	game_ended = true

	if score_manager.score >= target_score:
		show_message("🎉 You Win!")
	else:
		show_message("😢 You Lose. Try Again!")
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()

func on_player_win():
	if game_ended:
		return
	game_ended = true

	if timer and timer.is_stopped() == false:
		timer.stop()

	# Stop fish and disable further spawning
	for child in get_children():
		if child is CharacterBody2D:
			child.queue_free()

	show_message("🎉 You Win!")

func show_message(text):
	var label = get_node("MessageLabel")
	label.text = text
	label.visible = true
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.position = get_viewport_rect().size / 2

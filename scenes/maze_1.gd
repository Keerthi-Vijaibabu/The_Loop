extends Node2D

@onready var game_timer: Timer = $Timer
@onready var timer_label: Label = $CanvasLayer/Label

var time_left: int = 60  

func _ready():
	game_timer.start()
	time_left = int(game_timer.wait_time)
	update_timer_label()

func _process(_delta):
	if game_timer.time_left > 0:
		time_left = int(game_timer.time_left)
		update_timer_label()

func update_timer_label():
	timer_label.text = "Time Left: %ds" % time_left

func _on_Timer_timeout():
	timer_label.text = "Time's up!"
	get_tree().change_scene_to_file("res://scenes/MazeGameOver.tscn")

func _on_target_body_entered(body: Node2D) -> void:
	GlobalSceneManager.maze_time = time_left
	#timer_label.text = "Time's up!"
	get_tree().change_scene_to_file("res://scenes/MazeGameOver.tscn")

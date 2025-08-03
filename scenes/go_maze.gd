extends Node2D

@onready var time_label: Label = $TimeLabel
@onready var points_label: Label = $PointsLabel

var points = 0

func _ready() -> void:
	time_label.text = "Time: %d" % (60-GlobalSceneManager.maze_time)
	if (GlobalSceneManager.maze_time > 0 ):
		points = 2000
		GlobalSceneManager.try_no += 1
	GlobalSceneManager.curr_points = points
	points_label.text = "Points: %d" % points
	
	GlobalSceneManager.maze()

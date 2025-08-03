extends Node2D

@onready var time: Label = $Time
@onready var coins: Label = $Coins
@onready var points: Label = $Points
@onready var win: AudioStreamPlayer2D = $win
@onready var loss: AudioStreamPlayer2D = $loss

func _ready() -> void:
	time.text = "Time: %d" % (120- GlobalSceneManager.curr_time)
	coins.text = "Coins: %d" % GlobalSceneManager.curr_gold
	points.text = "Points: %d" % GlobalSceneManager.curr_points
	
	if GlobalSceneManager.curr_time > 0:
		win.play()
	else:
		loss.play()
	
	GlobalSceneManager.curr_time = 0
	GlobalSceneManager.curr_points = 0
	GlobalSceneManager.curr_gold = 0
	GlobalSceneManager.curr_egg = 0
	print(GlobalSceneManager.gold, GlobalSceneManager.points)

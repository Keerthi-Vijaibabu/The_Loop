extends Node2D

func _ready():
	$Label3.text = "Points: %d" % GlobalSceneManager.points
	$Label4.text = "Gold: %d" % GlobalSceneManager.gold
	
	await get_tree().create_timer(5.0).timeout
	
	get_tree().change_scene_to_file("res://scenes/main2.tscn")

extends Node2D

func _farm_body_entered(body: CharacterBody2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_1")

func change_scene_1():
	get_tree().change_scene_to_file("res://scenes/egg_collection/")

func _maze_body_entered(body: CharacterBody2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_2")

func change_scene_2():
	get_tree().change_scene_to_file("res://scenes/maze1.tscn")

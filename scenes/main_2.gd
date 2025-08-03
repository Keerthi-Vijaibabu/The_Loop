extends Node2D

func _on_farm_body_entered(body: CharacterBody2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_1")

func change_scene_1():
	get_tree().change_scene_to_file("res://scenes/mm_egg_collection.tscn")

func change_scene_2():
	get_tree().change_scene_to_file("res://scenes/mm_maze.tscn")
	
func check_progress():
	if (GlobalSceneManager.gold == 10000):
		get_tree().change_scene_to_file("res://scenes/main2.tscn")


func _on_maze_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_2")

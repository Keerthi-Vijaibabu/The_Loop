extends Node2D

@export var MAIN_PLAYER_MINING = preload("res://scenes/mining/main_mining.tscn")


func _on_mining_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_3")

func change_scene_3():
	get_tree().change_scene_to_file("res://scenes/mining/main_mining.tscn")
func change_scene_2():
	get_tree().change_scene_to_file("res://scenes/fishing/fishing_game.tscn")
func change_scene_1():
	get_tree().change_scene_to_file("res://scenes/mining/main_mining.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_2")


func _on_wood_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_1")

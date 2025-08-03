extends Node2D

@export var MAIN_PLAYER_MINING = preload("res://scenes/mining/main_mining.tscn")

@onready var point_label: Label = $CanvasLayer/PointLabel
@onready var gold_label: Label = $CanvasLayer/GoldLabel
@onready var stone_label: Label = $CanvasLayer/StoneLabel
@onready var wood_label: Label = $CanvasLayer/WoodLabel

func _ready() -> void:
	point_label.text = "Point: %d" % GlobalSceneManager.points
	gold_label.text = "Gold: %d" % GlobalSceneManager.gold
	stone_label.text = "Stone: %d" % GlobalSceneManager.stone
	wood_label.text = "Wood: %d" % GlobalSceneManager.wood

func _process(delta):
	point_label.text = "Point: %d" % GlobalSceneManager.points
	gold_label.text = "Gold: %d" % GlobalSceneManager.gold
	stone_label.text = "Stone: %d" % GlobalSceneManager.stone
	wood_label.text = "Wood: %d" % GlobalSceneManager.wood
	
	check_progress()

func _on_mining_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_3")

func change_scene_3():
	#get_tree().change_scene_to_file("res://scenes/mining/main_mining.tscn")
	pass
func change_scene_2():
	get_tree().change_scene_to_file("res://scenes/mm_fishing.tscn")
func change_scene_1():
	get_tree().change_scene_to_file("res://scenes/mm_mining.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_2")


func _on_wood_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		call_deferred("change_scene_1")
		
func check_progress():
	if (GlobalSceneManager.wood == 30) and (GlobalSceneManager.stone == 30) and (GlobalSceneManager.gold == 5000):
		get_tree().change_scene_to_file("res://scenes/main2.tscn")

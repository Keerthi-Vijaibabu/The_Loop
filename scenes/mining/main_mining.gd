extends Node2D

var rocks = preload("res://scenes/mining/rock.tscn")
var coins = preload("res://scenes/mining/gold.tscn")
var stones = preload("res://scenes/mining/stone.tscn")

const START_POS := Vector2(150, 485)


var gold = 0
var stone = 0

const START_SPEED = 10.0
var speed = START_SPEED
var screen_size: Vector2

const ROCK_Y = 500
var last_spawn_x = 0
var rock_spawn_gap_range = Vector2(300, 600)  

var can_spawn_rocks = false

var last_coin_x = 0
var coin_spawn_gap_range = Vector2(2000, 5000) 
const COIN_Y = ROCK_Y - 50

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	add_to_group("game")
	new_game()

func new_game():
	$bgMusic.play()
	gold = 0
	stone = 0
	last_spawn_x = START_POS.x
	last_coin_x = START_POS.x
	can_spawn_rocks = false
	$Mining_Player.position = START_POS
	$Mining_Player.velocity = Vector2.ZERO
	$bg/Ground.position = Vector2.ZERO
	$CanvasLayer/goldLabel.text  = "Gold: %d" % gold
	$RockSpawnTimer.stop()
	$RockSpawnTimer.start()
	
	for child in get_children():
		if child.is_in_group("rock") or child.is_in_group("gold"):
			child.queue_free()
			

func _process(_delta):
	$Mining_Player.position.x += speed
	if ($Mining_Player.position.x - $bg/Ground.position.x) > screen_size.x * 1.5:
		$bg/Ground.position.x += screen_size.x
	
	if $bgMusic.playing == false:
		$bgMusic.play()
		
	if can_spawn_rocks and $Mining_Player.position.x > last_spawn_x:
		var gap = randf_range(rock_spawn_gap_range.x, rock_spawn_gap_range.y)
		var next_x = last_spawn_x + gap
		spawn_rock(next_x)
		last_spawn_x = next_x
	
	if $Mining_Player.position.x > last_coin_x:
		var gap = randf_range(coin_spawn_gap_range.x, coin_spawn_gap_range.y)
		var next_x = last_coin_x + gap
		spawn_coins(next_x)
		last_coin_x = next_x
	
		if $Mining_Player.position.x > last_coin_x + 1000:  # additional check to prevent crowding
			var stone_chance = randi() % 2  # 50% chance
			if stone_chance == 0:
				gap = randf_range(coin_spawn_gap_range.x, coin_spawn_gap_range.y)
				next_x = last_coin_x + gap
				spawn_stones(next_x)


func spawn_rock(x_pos: float):
	var rock = rocks.instantiate()
	rock.position = Vector2(x_pos, ROCK_Y)
	add_child(rock)
	
func add_gold(amount: int):
	gold += amount
	$CanvasLayer/goldLabel.text  = "Gold: %d" % gold
	
func add_stone(amount: int):
	stone += amount
	$CanvasLayer/stoneLabel.text = "Stone: %d" % stone

func _on_rock_spawn_timer_timeout():
	print("Timer started")
	can_spawn_rocks = true

func spawn_coins(x_pos: float):
	for i in range(0,10):
		var coin = coins.instantiate()
		coin.position = Vector2(x_pos, COIN_Y)
		add_child(coin)
		
func spawn_stones(x_pos: float):
	var gap = 40
	for i in range(10):
		var s = stones.instantiate()
		s.position = Vector2(x_pos + i * gap, COIN_Y)
		add_child(s)


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/mining/gameover.tscn")

extends Node2D

var rocks = preload("res://scenes/mining/rock.tscn")
var coins = preload("res://scenes/mining/gold.tscn")

const START_POS := Vector2(150, 485)


var gold = 0
var stones = 0

const START_SPEED = 10.0
var speed = START_SPEED
var screen_size: Vector2

const ROCK_Y = 500
var last_spawn_x = 0
var rock_spawn_gap_range = Vector2(500, 1600)  

var can_spawn_rocks = false

var last_coin_x = 0
var coin_spawn_gap_range = Vector2(500, 1600) 

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	add_to_group("game")
	new_game()

func new_game():
	gold = 0
	stones = 0
	can_spawn_rocks = false
	$Mining_Player.position = START_POS
	$Mining_Player.velocity = Vector2.ZERO
	#$CharacterBody2D/Camera2D.position = CAM_START_POS
	$bg/Ground.position = Vector2.ZERO

func _process(_delta):
	$Mining_Player.position.x += speed

	if ($Mining_Player.position.x - $bg/Ground.position.x) > screen_size.x * 1.5:
		$bg/Ground.position.x += screen_size.x
	#await get_tree().create_timer(1).timeout
		
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

func spawn_rock(x_pos: float):
	var rock = rocks.instantiate()
	rock.position = Vector2(x_pos, ROCK_Y)
	add_child(rock)
	
func add_gold(amount: int):
	gold += amount
	print("Gold:", gold)

func _on_rock_spawn_timer_timeout():
	print("Timer started")
	can_spawn_rocks = true

func spawn_coins(x_pos: float):
	var coin = coins.instantiate()
	coin.position = Vector2(x_pos, ROCK_Y)
	add_child(coin)

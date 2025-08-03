extends Node2D

const stones = preload("res://scenes/mining/stone.tscn")

const START_POS := Vector2(150, 485)

var stone = 0

const START_SPEED = 10.0
var speed = START_SPEED
var screen_size: Vector2

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	add_to_group("game")
	new_game()
	
func new_game():
	$bgMusic.play()
	#gold = 0
	stone = 0
	$Mining_Player.position = START_POS
	$Mining_Player.velocity = Vector2.ZERO
	$bg/Ground.position = Vector2.ZERO
	#$CanvasLayer/goldLabel.text  = "Gold: %d" % gold
	$RockSpawnTimer.stop()
	$RockSpawnTimer.start()
	
	for child in get_children():
		if child.is_in_group("rock") or child.is_in_group("gold"):
			child.queue_free()
			
func _process(_delta):
	$CanvasLayer/TimerLabel.text = "TIME: %d" % int($Timer.time_left)
	
	$Mining_Player.position.x += speed
	if ($Mining_Player.position.x - $bg/Ground.position.x) > screen_size.x * 1.5:
		$bg/Ground.position.x += screen_size.x
	
	if $bgMusic.playing == false:
		$bgMusic.play()
		
	
		if $Mining_Player.position.x > last_coin_x + 1000:  # additional check to prevent crowding
			var stone_chance = randi() % 2  # 50% chance
			if stone_chance == 0:
				gap = randf_range(coin_spawn_gap_range.x, coin_spawn_gap_range.y)
				next_x = last_coin_x + gap
				spawn_stones(next_x)

func add_stone(amount: int):
	stone += amount
	$CanvasLayer/stoneLabel.text = "Stone: %d" % stone
	
func spawn_stones(x_pos: float):
	var gap = 40
	for i in range(10):
		var s = stones.instantiate()
		s.position = Vector2(x_pos + i * gap, COIN_Y)
		add_child(s)

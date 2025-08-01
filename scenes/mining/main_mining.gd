extends Node2D

const START_POS := Vector2(150, 485)


var gold = 0
var stones = 0

const START_SPEED = 10.0
var speed = START_SPEED
var screen_size: Vector2



func _ready():
	screen_size = get_viewport().get_visible_rect().size
	add_to_group("game")
	new_game()

func new_game():
	gold = 0
	stones = 0

	$CharacterBody2D.position = START_POS
	$CharacterBody2D.velocity = Vector2.ZERO
	#$CharacterBody2D/Camera2D.position = CAM_START_POS
	$bg/Ground.position = Vector2.ZERO

func _process(_delta):
	$CharacterBody2D.position.x += speed

	if ($CharacterBody2D.position.x - $bg/Ground.position.x) > screen_size.x * 1.5:
		$bg/Ground.position.x += screen_size.x

extends Node2D

@export var spawn_object: PackedScene = preload("res://scenes/egg_collection/egg.tscn")
@export var level_duration_sec: float = 120.0  
@export var spawn_number = 120

@onready var time_label: Label = $TimeLabel
var remaining_time: float = 120.0
@onready var warning_color: Color = Color.RED
@onready var normal_color: Color = Color.WHITE
@onready var audio_player= $Timer_Beeps 
@onready var original_font_scale: float = time_label.scale.x  
var flashing: bool = false

var missed_eggs: int = 0
@onready var scoremanager: Node2D = $ScoreManager


var random = RandomNumberGenerator.new()

func _ready():
	remaining_time = level_duration_sec
	start_level_timer()
	spawn()

func _process(delta):
	if remaining_time > 0:
		remaining_time -= delta

		var minutes = int(remaining_time) / 60
		var seconds = int(remaining_time) % 60
		time_label.text = "%02d:%02d" % [minutes, seconds]

		# Flash in last 10 seconds
		if remaining_time <= 10:
			time_label.modulate = warning_color
			flash_label()
		else:
			time_label.modulate = normal_color
				
		if scoremanager.score == 10:
			await get_tree().create_timer(2).timeout 
			on_level_complete()
		
	else:
		remaining_time = 0
		time_label.text = "00:00"
		await get_tree().create_timer(2).timeout
		on_level_complete()

func flash_label():
	var flash_speed = 8.0  # higher = faster flicker
	var scale_factor = 1.0 + 0.2 * sin(Time.get_ticks_msec() / 1000.0 * flash_speed)
	time_label.scale = Vector2(scale_factor, scale_factor)

func start_level_timer():
	var timer = Timer.new()
	timer.wait_time = level_duration_sec
	timer.one_shot = true
	timer.timeout.connect(on_level_complete)
	add_child(timer)
	timer.start()

func getRandomPosition(size) -> Vector2:
	random.randomize()
	var x = random.randf_range(-abs(size/2), abs(size/2))
	var y = -1500
	return Vector2(x, y)

func spawn():
	for i in range(spawn_number):
		await get_tree().create_timer(1).timeout
		var obj = spawn_object.instantiate()
		obj.position = getRandomPosition(1024)
		add_child(obj)

func on_level_complete():
	print("Level Complete!")
	get_tree().change_scene_to_file("res://scenes/egg_collection/Game_over.tscn")


func _on_timer_timeout() -> void:
	audio_player.play()

func on_egg_missed():
	missed_eggs += 1
	print("Missed eggs: %d" % missed_eggs)

	if missed_eggs >= 3:
		reset_score()

func reset_score():
	print("Missed 3 eggs! Score reset.")
	scoremanager.score = 0
	missed_eggs = 0 
	

func _on_miss_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("egg"):
		print("Missed")
		on_egg_missed()
		body.queue_free()

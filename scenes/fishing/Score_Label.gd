extends Label

var score = 0
var score_label

func _ready():
	score_label = self
	update_label()

func reset_score():
	score = 0
	update_label()

func add_point():
	score += 1
	print("✅ Score updated to:", score)
	update_label()

	# ✅ Check for instant win
	if score >= 20:
		var game_node = get_tree().get_root().get_node("FishingGame")
		if game_node:
			game_node.on_player_win()

func update_label():
	text = "Fish Caught: %d" % score

extends Node

var score = 0
var score_label

func _ready():
	# Correct way to find sibling node
	score_label = get_parent().get_node_or_null("ScoreLabel")
	if score_label:
		print("✅ ScoreLabel found!")
	else:
		print("❌ ScoreLabel not found!")

	update_label()  # To show initial score

func reset_score():
	score = 0
	update_label()

func add_point():
	score += 1
	print("✅ Score updated to:", score)
	update_label()

func update_label():
	if score_label:
		score_label.text = "Fish Caught: %d" % score
	else:
		print("❌ Cannot update label, ScoreLabel missing")

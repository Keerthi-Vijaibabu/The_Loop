extends Node

var score = 0
var score_label

func _ready():
	score_label = get_parent().get_node_or_null("ScoreLabel")
	

	update_label()  

func reset_score():
	score = 0
	update_label()

func add_point():
	score += 1
	update_label()

func update_label():
	if score_label:
		score_label.text = "Fish Caught: %d" % score
	else:
		print("❌ Cannot update label, ScoreLabel missing")

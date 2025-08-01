extends Label

func _process(_delta):
	var ScoreManager = get_node("../Scoremanager")
	text = "Score: %d" % ScoreManager.score

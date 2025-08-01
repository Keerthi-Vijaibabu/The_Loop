extends Label

func _process(_delta):
	var ScoreManager = get_parent().get_node("ScoreManager")
	text = "Score: %d" % ScoreManager.score

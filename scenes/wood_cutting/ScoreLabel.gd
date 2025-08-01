extends Label

func _process(delta):
	var ScoreManager =get_tree().get_root().get_node("WoodCutting/ScoreManager")
	text = "Score: %d" % ScoreManager.score

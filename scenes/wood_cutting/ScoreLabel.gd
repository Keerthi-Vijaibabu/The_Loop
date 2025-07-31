extends Label

func _process(delta):
	var score_manager = get_tree().get_root().get_node("Main/ScoreManager")
	var ScoreManager =get_tree().get_root().get_node("WoodCutting/ScoreManager")
	text = "Score: %d" % ScoreManager.score

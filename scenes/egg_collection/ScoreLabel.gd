extends Label

func _process(delta):
	var ScoreManager =get_tree().get_root().get_node("EggCollection/ScoreManager")
	text = "Eggs Collected: %d" % ScoreManager.score

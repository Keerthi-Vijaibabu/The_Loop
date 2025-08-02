extends Label

var score_manager = null
func _ready():
	score_manager = get_parent().get_node_or_null("ScoreManager")
	if score_manager == null:
		print("❌ ScoreManager not found!")
	else:
		print("✅ ScoreManager found:", score_manager)


func _process(_delta):
	if score_manager:
		text = "Fish Caught: %d" % score_manager.score

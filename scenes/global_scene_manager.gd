extends Node

var score: int = 0
var high_score: int = 0

const SAVE_PATH := "user://save_data.json"

func save_game():
	var save_data = {
		"score": score,
		"high_score": high_score
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()

		var result = JSON.parse_string(content)
		if result:
			score = result.get("score", 0)
			high_score = result.get("high_score", 0)

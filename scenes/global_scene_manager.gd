extends Node

#level 1
var wood: int = 0
var stone: int = 0
var gold: int = 0
var points: int = 0

#level 2


#maze_time
var maze_time = 0

const SAVE_PATH := "user://save_data.json"

func save_game():
	var save_data = {
		"gold": gold,
		"stone": stone
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
			gold = result.get("gold", 0)
			stone = result.get("stone", 0)

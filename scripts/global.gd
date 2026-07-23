extends Node

var scores = {
	"thyroid": 0,
	"pancreas": 0,
	"adrenal": 0,
	"pituitary": 0,
	
}

func reset_scores():
	scores = {
		"thyroid": 0,
		"pancreas": 0,
		"adrenal": 0,
		"pituitary": 0,
}

func update_scores(key, score):
	#scores[0][1] = max(scores[0][1], score)
	#scores[1][1] = max(scores[1][1], score)
	#scores[2][1] = max(scores[2][1], score)
	#scores[3][1] = max(scores[3][1], score)
	#print(key)
	#print(score)
	#print(scores[key])
	scores[key] = max(scores[key], score)




func _ready():
	print(OS.get_user_data_dir())
	load_scores()
	print(global.scores)

func save_scores():
	var file = FileAccess.open("user://scores.save", FileAccess.WRITE)
	file.store_var(scores)
	file.close()
	
func load_scores():
	if FileAccess.file_exists("user://scores.save"):
		var file = FileAccess.open("user://scores.save", FileAccess.READ)
		scores = file.get_var()
		file.close()

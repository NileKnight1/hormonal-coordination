extends Node

var scores = [
	["thyroid", 0],
	["pancreas", 0],
	["adrenal", 0],
	["pituitary", 0],
	
]

func _ready():
	load_scores()

func save_scores():
	var file = FileAccess.open("user://scores.save", FileAccess.WRITE)
	file.store_var(scores)
	file.close()
	
func load_scores():
	if FileAccess.file_exists("user://scores.save"):
		var file = FileAccess.open("user://scores.save", FileAccess.READ)
		scores = file.get_var()
		file.close()

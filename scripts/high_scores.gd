extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()

func update():
	$pancreas.text = "Pancreas: " + str(global.scores["pancreas"])
	$thyroid.text = "Thyroid: " + str(global.scores["thyroid"])
	$adrenal.text = "Adrenal: " + str(global.scores["adrenal"])
	$pituitary.text = "Pituitary: " + str(global.scores["pituitary"])
	#$sex.text = "Sex: " + str(global.scores)

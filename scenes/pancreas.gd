extends Node2D


@onready var glucose_level_label = $Node/glucose_level
var glucose_level = 90


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_insulin_button_down() -> void:
	glucose_level_label.text = "Glucose level: " + str(glucose_level - 5)
	glucose_level -= 5


func _on_glucagon_button_down() -> void:
	glucose_level_label.text = "Glucose level: " + str(glucose_level + 5)
	glucose_level += 5

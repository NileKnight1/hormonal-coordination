extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_glands_button_down() -> void:
	$CanvasLayer/main.visible = 0
	$CanvasLayer/glands.visible = 1


func _on_back_button_down() -> void:
	$CanvasLayer/main.visible = 1
	$CanvasLayer/glands.visible = 0



func _on_pancreas_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/pancreas.tscn")
	


func _on_thymus_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/thymus.tscn")


func _on_thyroid_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/pancreas.tscn")

func _on_adrenal_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/adrenal.tscn")
	

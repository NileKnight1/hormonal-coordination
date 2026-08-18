extends Node2D

@onready var cam_pituitary = $pituitray/Camera2D
@onready var cam_thyroid = $thyroid/Camera2D
@onready var cam_pancreas = $pancreas/Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	cam_pituitary.enabled = 0
	cam_thyroid.enabled = 1


func _on_button2_pressed() -> void:
	cam_thyroid.enabled = 0
	cam_pancreas.enabled = 1


func _on_button3_pressed() -> void:
	cam_thyroid.enabled = 1
	cam_pancreas.enabled = 0


func _on_button4_pressed() -> void:
	cam_pituitary.enabled = 1
	cam_thyroid.enabled = 0

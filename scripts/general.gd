extends Node2D

@onready var cam_pituitary = $pituitray/Camera2D
@onready var cam_thyroid = $thyroid/Camera2D
@onready var cam_pancreas = $pancreas/Camera2D
@onready var timer_1s = $"1s"


@onready var label_glucose = $CanvasLayer/Control/Label2
@onready var label_calcium = $CanvasLayer/Control2/Label2
@onready var label_water = $CanvasLayer/Control3/Label2
@onready var label_hr = $CanvasLayer/Control4/Label2
@onready var label_bp = $CanvasLayer/Control5/Label2
@onready var label_bmr = $CanvasLayer/Control6/Label2

var glucose = 85
var calcium = 95.0
var water = 100
var hr = 70
var bp = 120
var bmr = 100



func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass
	

func _on_s_timeout() -> void:
	label_glucose.text = str(glucose) + " mg"
	label_calcium.text = str(calcium/10) + " mg"
	label_water.text = str(water) + " %"
	label_hr.text = str(hr) + " bpm"
	label_bp.text = str(bp) + " mmHg"
	label_bmr.text = str(bmr) + " %"


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
	
	


func _on_tsh_pressed() -> void:
	hr += 3
	bp += 2
	bmr += 5

func _on_acth_pressed() -> void:
	glucose += 3
	water += 1
	hr += 1
	bp += 3
	bmr += 2

func _on_gh_pressed() -> void:
	glucose += 2
	water += 1
	bp += 1
	bmr += 3

func _on_adh_pressed() -> void:
	water += 5
	bp += 3

func _on_calcitonin_pressed() -> void:
	calcium -= 2

func _on_parathormone_pressed() -> void:
	calcium += 2

func _on_insulin_pressed() -> void:
	glucose -= 8

func _on_glucagon_pressed() -> void:
	glucose += 4

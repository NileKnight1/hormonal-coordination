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


@onready var line_glucose = $CanvasLayer/Control/Label3
@onready var line_calcium = $CanvasLayer/Control2/Label3
@onready var line_water = $CanvasLayer/Control3/Label3
@onready var line_hr = $CanvasLayer/Control4/Label3
@onready var line_bp = $CanvasLayer/Control5/Label3
@onready var line_bmr = $CanvasLayer/Control6/Label3

@onready var msg_bg = $CanvasLayer/bg
@onready var msg_label = $CanvasLayer/Label4

var extreme = Color(0x89000cff)
var medium = Color(0xd1ff00ff)
var perfect = Color(0x2ebc00ff)

var glucose = 85
var calcium = 95.0
var water = 100
var hr = 70
var bp = 120
var bmr = 100

var events = [
	["Human is eating a cucumber."		, 8, 0, 0, 0, 0, 0],
	["Human is eating an apple."		, 8, 0, 0, 0, 0, 0],
	["Human is eating some bread."		, 12, 0, 0, 0, 0, 0],
	["Human is eating some pasta."		, 18, 0, 0, 0, 0, 0],
	["Human is eating pizza."			, 35, 0, 0, 0, 0, 0],
	["Human is eating a burger."		, 45, 0, 0, 0, 0, 0],
	["Human is eating a piece of cake."	, 50, 0, 0, 0, 0, 0],
	["Human is eating lots of candy."	, 60, 0, 0, 0, 0, 0],

	["Human is drinking milk."				, 0, 6, 0, 0, 0, 0],
	["Human is eating fish."				, 0, 4, 0, 0, 0, 0],
	["Human is having cheese."				, 0, 3, 0, 0, 0, 0],
	["Human is taking calcium supplement."	, 0, 8, 0, 0, 0, 0],
	
	["Human is drinking water.",		0, 0, 8, 0, 2, 0],
	["Human is sweating heavily.",		0, 0, -15, 0, -5, 0],
	["Human urinated excessively.",		0, -3, -12, 0, -4, 0],
	
	["Human is taking a walk.",	-		-5, -1, 0, 5, 3, 2],
	["Human is carying heavy bags.", 	-8, -2, 0, 10, 5, 3],
	["Human is doing intense exercise.", -20, -6, 0, 25, 12, 8],
	
	["Human entered a cold environment.", 0, 0, 0, 0, 0, -8],
	
	["Experienced sudden fear.", 8, 0, 0, 20, 12, 5],
	
]






func _ready() -> void:
	await get_tree().create_timer(3).timeout
	show_msg("Human is playing minecraft.")


func _process(delta: float) -> void:
	pass
	

func _on_s_timeout() -> void:
	label_glucose.text = str(glucose) + " mg"
	label_calcium.text = str(calcium/10) + " mg"
	label_water.text = str(water) + " %"
	label_hr.text = str(hr) + " bpm"
	label_bp.text = str(bp) + " mmHg"
	label_bmr.text = str(bmr) + " %"
	
	if glucose < 60:
		line_glucose.add_theme_color_override("font_color", extreme)
	elif glucose < 70:
		line_glucose.add_theme_color_override("font_color", medium)
		
	elif glucose < 110:
		line_glucose.add_theme_color_override("font_color", perfect)
		
	elif glucose < 140:
		line_glucose.add_theme_color_override("font_color", medium)
	else:
		line_glucose.add_theme_color_override("font_color", extreme)

	if calcium < 70:
		line_calcium.add_theme_color_override("font_color", extreme)
	elif calcium < 80:
		line_calcium.add_theme_color_override("font_color", medium)
	elif calcium < 105:
		line_calcium.add_theme_color_override("font_color", perfect)
	elif calcium < 115:
		line_calcium.add_theme_color_override("font_color", medium)
	else:
		line_calcium.add_theme_color_override("font_color", extreme)

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
	
func show_msg(msg):
	msg_bg.visible = 1
	msg_label.text = msg
	
	msg_bg.modulate.a = 0.0
	create_tween().tween_property(msg_bg, "modulate:a", 1.0, 0.3)
	msg_label.modulate.a = 0.0
	create_tween().tween_property(msg_label, "modulate:a", 1.0, 0.3)
	
	
	await get_tree().create_timer(4).timeout
		
	create_tween().tween_property(msg_bg, "modulate:a", 0.0, 0.3)
	create_tween().tween_property(msg_label, "modulate:a", 0.0, 0.3)
	
	
	
	await get_tree().create_timer(3).timeout
	
	msg_bg.visible = 0
	msg_label.text = ""

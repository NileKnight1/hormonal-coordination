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
@onready var time_label = $CanvasLayer/Label5


var click = preload("res://audio/click.wav")
var lose = preload("res://audio/sudden.mp3")
var right = preload("res://audio/right.mp3")
var wrong = preload("res://audio/wrong.mp3")

var alive = 1

func play_sound(sound):
	var temp = AudioStreamPlayer.new()
	temp.stream = sound
	add_child(temp)
	
	temp.finished.connect(temp.queue_free)
	temp.play()
	

var elapsed_time = 0

var dif = 3
var extreme_count = 0
var extreme_time = 0



var glucose = 85
var calcium = 95.0
var water = 100
var hr = 70
var bp = 120
var bmr = 100

var events = [
	["Human is eating a cucumber.",		8, 0, 0, 0, 0, 0],
	["Human is eating an apple.",		8, 0, 0, 0, 0, 0],
	["Human is eating some bread.", 	12, 0, 0, 0, 0, 0],
	["Human is eating some pasta.",		18, 0, 0, 0, 0, 0],
	["Human is eating pizza.",			35, 0, 0, 0, 0, 0],
	["Human is eating a burger.",		45, 0, 0, 0, 0, 0],
	["Human is eating a piece of cake.",50, 0, 0, 0, 0, 0],
	["Human is eating lots of candy.",	60, 0, 0, 0, 0, 0],

	["Human is drinking milk.",					0, 6, 0, 0, 0, 0],
	["Human is eating fish.",					0, 4, 0, 0, 0, 0],
	["Human is having cheese.",					0, 3, 0, 0, 0, 0],
	["Human is taking a calcium supplement.",	0, 8, 0, 0, 0, 0],

	["Human is drinking water.",		0, 0, 8, 0, 0, 0],
	["Human is sweating heavily.",		0, 0, -15, 0, -5, 0],
	["Human is urinating excessively.",	0, -3, -12, 0, -4, 0],

	["Human is resting for a long time.",0, 0, 0, -10, -5, 0],
	["Human is sleeping.",				0, 0, 0, -8, -3, -2],
	["Human is very relaxed.",			0, 0, 0, -5, -2, 0],

	["Human has lost some blood.",	0, 0, -3, -5, -15, 0],
	["Human is dehydrated.",		0, 0, -10, -3, -8, 0],

	["Human entered a cold environment.",		0, 0, 0, 0, 0, -10],
	["Human has been inactive for a long time.",0, 0, 0, 0, 0, -8],
	["Human is fasting for a long time.",		-10, 0, 0, 0, 0, -5],
]






func _ready() -> void:
	#global.reset_scores()
	await get_tree().create_timer(3).timeout
	
	
	
	#show_msg("Human is playing minecraft.")
	run()


func _process(delta: float) -> void:
	pass

func _on_s_timeout() -> void:
	extreme_count = 0
	
	label_glucose.text = str(glucose) + " mg"
	label_calcium.text = str(calcium/10) + " mg"
	label_water.text = str(water) + " %"
	label_hr.text = str(hr) + " bpm"
	label_bp.text = str(bp) + " mmHg"
	label_bmr.text = str(bmr) + " %"
	
	if glucose < 60:
		line_glucose.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
	elif glucose < 70:
		line_glucose.add_theme_color_override("font_color", global.medium)
		
	elif glucose < 110:
		line_glucose.add_theme_color_override("font_color", global.perfect)
		
	elif glucose < 140:
		line_glucose.add_theme_color_override("font_color", global.medium)
	else:
		line_glucose.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		

	if calcium < 70:
		line_calcium.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		
	elif calcium < 80:
		line_calcium.add_theme_color_override("font_color", global.medium)
	elif calcium < 105:
		line_calcium.add_theme_color_override("font_color", global.perfect)
	elif calcium < 115:
		line_calcium.add_theme_color_override("font_color", global.medium)
	else:
		line_calcium.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		

	if water < 80:
		line_water.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		
	elif water < 90:
		line_water.add_theme_color_override("font_color", global.medium)
	elif water < 110:
		line_water.add_theme_color_override("font_color", global.perfect)
	elif water < 120:
		line_water.add_theme_color_override("font_color", global.medium)
	else:
		line_water.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		
		
	if hr < 50:
		line_hr.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		
	elif hr < 60:
		line_hr.add_theme_color_override("font_color", global.medium)
	elif hr < 100:
		line_hr.add_theme_color_override("font_color", global.perfect)
	elif hr < 120:
		line_hr.add_theme_color_override("font_color", global.medium)
	else:
		line_hr.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		
		
	if bp < 90:
		line_bp.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		
	elif bp < 100:
		line_bp.add_theme_color_override("font_color", global.medium)
	elif bp < 130:
		line_bp.add_theme_color_override("font_color", global.perfect)
	elif bp < 140:
		line_bp.add_theme_color_override("font_color", global.medium)
	else:
		line_bp.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		
		
	if bmr < 80:
		line_bmr.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
		
	elif bmr < 90:
		line_bmr.add_theme_color_override("font_color", global.medium)
	elif bmr < 110:
		line_bmr.add_theme_color_override("font_color", global.perfect)
	elif bmr < 120:
		line_bmr.add_theme_color_override("font_color", global.medium)
	else:
		line_bmr.add_theme_color_override("font_color", global.extreme)
		extreme_count += 1
	
	#print (extreme_time)
	
	if extreme_count > (dif -1):
		extreme_time += 1
	else:
		extreme_time = 0
	
	if extreme_time > 4:
		death()
	
	elapsed_time += 1
	var mins = elapsed_time / 60
	var seconds = elapsed_time - (mins*60)
	var hours = mins / 60
	mins = mins - (hours*60) 
	
	
	time_label.text = "Elapsed Time: "
	if hours < 10:
		time_label.text += "0"
	time_label.text +=  str(hours) + ":"
	if mins < 10:
		time_label.text += "0"
	time_label.text +=  str(mins) + ":"
	if seconds < 10:
		time_label.text += "0"
	time_label.text +=  str(seconds)
	


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
	#bmr += 2

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

func _on_adrenaline_pressed() -> void:
	glucose += 8
	hr += 15
	bp += 10

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


func run():
	
	while alive:
		var tempx = randi_range(0, len(events)-1)
		event(events[tempx])
		await get_tree().create_timer(5).timeout
	
	
func event(event):
	show_msg(event[0])
	glucose += event[1]
	calcium += event[2]
	water += event[3]
	hr += event[4]
	bp += event[5]
	bmr += event[6]
	
func death():
	alive = 0
	print("dead")
	play_sound(lose)
	global.update_scores("general", elapsed_time)
	$music.stop()
	$"1s".stop()

	
	$CanvasLayer/bg2.visible = 1
	$CanvasLayer/but.visible = 1
	

func _on_but_pressed() -> void:
	play_sound(click)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

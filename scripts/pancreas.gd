extends Node2D


#@onready var glucose_level_label = $Node/glucose_level
@onready var status = $Node/status
@onready var cooldown = $cooldown
@onready var b1 = $Node/insulin
@onready var b2 = $Node/glucagon
@onready var hormones = $hormones
@onready var music = $music
@onready var line_glucose = $Node/Control/Label3
@onready var label_glucose = $Node/Control/Label2


var insulin_scripts = preload("res://scripts/pancreas_insulin.gd")
var glucagon_scripts = preload("res://scripts/pancreas_insulin.gd")

var click = preload("res://audio/click.wav")
var lose = preload("res://audio/sudden.mp3")
var sec = preload("res://audio/message.mp3")


func play_sound(sound):
	var temp = AudioStreamPlayer.new()
	temp.stream = sound
	add_child(temp)
	
	temp.finished.connect(temp.queue_free)
	temp.play()
	

#var bg_music = preload("res://audio/fluid.mp3")


var waiting_time = 10
var alive = 1


var glucose_level = 85
var score = 0


#
#func wait(x):
	#await get_tree().create_timer(x).timeout

var food = [
	["eating a cucumber.", 8],
	["eating an apple.", 8],
	["eating some bread.", 12],
	["eating some pasta.", 18],
	
	["eating pizza.", 35],
	["eating a burger.", 45],
	["eating a piece of cake.", 50],
	["eating lots of candy.", 60]
]

var actions = [
	["carrying grocery bags.", 10],
	["taking a walk.", 10],
	["doing little housework.", 10],
	
	["moving furniture.", 25],
	["fast-walking.", 25],
	["climbing stairs.", 25],
	
	["sprinting.", 45],
	["doing intense workout.", 45],
]

func _ready() -> void:
	glucose_change(0, 1)
	#music.play()
	#print(global.scores)[[[[[
	await get_tree().create_timer(5).timeout
	
	
	run()

func _on_s_timeout() -> void:
	
	$Node/Control/Label2.text = str(glucose_level) + " mg"
	
	if glucose_level < 60:
		line_glucose.add_theme_color_override("font_color", global.extreme)
	elif glucose_level < 70:
		line_glucose.add_theme_color_override("font_color", global.medium)
		
	elif glucose_level < 110:
		line_glucose.add_theme_color_override("font_color", global.perfect)
		
	elif glucose_level < 140:
		line_glucose.add_theme_color_override("font_color", global.medium)
	else:
		line_glucose.add_theme_color_override("font_color", global.extreme)
	
		
	if glucose_level < 40:
		death()
	if glucose_level > 300:
		death()
	
	if alive:
		if score < 0:
			score = 0
		elif glucose_level < 60:
			score -= 3
		elif glucose_level < 70:
			score += 1
		elif glucose_level < 110:
			score += 2
		elif glucose_level < 140:
			score += 1
		elif glucose_level != 0:
			score -= 3
			
	if score < 0:
			score = 0
	$score.text = "Score: " + str(score)
		

#
#func _process(delta: float) -> void:
	#
	#if alive:
		#if score < 0: 
			#return
		#elif glucose_level < 60:
			#score -= 3
		#elif glucose_level < 70:
			#score += 1
		#elif glucose_level < 110:
			#score += 2
		#elif glucose_level < 140:
			#score += 1
		#else:
			#score -= 3
			#
	#$Node/score.text = "Score: " + str(score/60)
	#
func death():
	print("You're dead")
	b1.disabled = 1
	b2.disabled = 1 
	$"1s".stop()
	$cooldown.stop()
	$general.stop()
	$music.stop()
	$Node/status.visible = 0
	$bg.visible = 1
	$but.visible = 1
	
	alive = 0
	#global.scores[1] = ["pancreas", score/60]
	global.update_scores("pancreas", score)
	
	print(global.scores)
	play_sound(lose)
	
	#global.save_scores()

func run():
	while alive:
		var temp = randi_range(0,1)
		
		if !temp:
			temp = randi_range(0,len(food)-1)
			print(food[temp])
			status.text = "You're " + food[temp][0]
			await get_tree().create_timer(1).timeout
			status.text = ""
			
			glucose_change(food[temp][1], 1)
		else:
			temp = randi_range(0,len(actions)-1)
			print(actions[temp])
			status.text = "You're " + actions[temp][0]
			await get_tree().create_timer(1).timeout
			status.text = ""
			
			
			glucose_change(actions[temp][1], -1)
			
			
			
		await get_tree().create_timer(waiting_time).timeout
		
	
func glucose_change(x,s):
	var temp
	var sum = 0
	
	while x > 0:
		temp = randi_range(1, x)
		x -= temp
		#print(temp)
		
		glucose_level += temp * s
		#label_glucose.text = "Glucose level: " + str(glucose_level)
		await get_tree().create_timer(1).timeout


func _on_insulin_button() -> void:
	play_sound(click)
	cooldown.start()
	b1.disabled = 1
	b2.disabled = 1
	print("Insulin")
	
	for i in range(4):
		
		var insulin = preload("res://scenes/insulin.tscn").instantiate()
		insulin.scale = Vector2(0.127, 0.127)
		insulin.position = Vector2(69, 49)
		insulin.set_script(insulin_scripts)
		hormones.add_child(insulin)
		play_sound(sec)
		await get_tree().create_timer(0.2).timeout

	
	print(hormones)
	
	
	glucose_change(80, -1)


func _on_glucagon_button() -> void:
	play_sound(click)
	
	cooldown.start()
	b1.disabled = 1
	b2.disabled = 1
	print("Glucagon")
	
	for i in range(2):
		var glucagon = preload("res://scenes/glucagon.tscn").instantiate()
		glucagon.scale = Vector2(0.127, 0.127)
		glucagon.position = Vector2(69, 49)
		glucagon.set_script(glucagon_scripts)
		hormones.add_child(glucagon)
		play_sound(sec)
		
		await get_tree().create_timer(0.2).timeout
		
		
	glucose_change(4, 1)
	


func _on_cooldown_timeout() -> void:
	b1.disabled = 0
	b2.disabled = 0


func _on_general_timeout() -> void:
	if waiting_time > 4:
		waiting_time -= 1


func _on_menu_pressed() -> void:
	play_sound(click)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

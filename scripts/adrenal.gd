extends Node2D


var cur_event

@onready var event = $Control/event
@onready var adrenaline =$Control/adrenaline
@onready var general = $general

var alive = 1
var score = 0
var health = 3
var waiting_time = 5

var glucose_level = 85
var heart_rate = 70
var blood_pressure = 120
var digestion = 0

func _ready() -> void:
	print(adrenaline.position)
	run()


var list1 = [
	"A tiger is attacking you.",
	"Earthquake is happening.",
	"Your house is on fire.",
	"You're being chased by a robber."
]
var list2 = [
	"You're in final exam.",
	"You're giving a presentaion.",
	"You're in a boxing match.",
	"You're kicking a penalty."
]
var list3 = [
	"You're reading a book.",
	"You're programming.",
	"You're eating dinner",
	"You're drawing."
]
var list4 = [
	"You're sleeping.",
	"You're having a braing surgery.",
	"You're meditating",
	"You're relaxing",
]

func change():
	adrenaline.disabled = 1
	
	glucose_level += 40
	heart_rate += 10
	blood_pressure += 10
	digestion = 1
	$Control/glucose_level.text = "Glucose Level: %d mg/dL" % glucose_level
	$Control/heart_rate.text = "Heart Rate: %d bpm" % heart_rate
	$"Control/blood pressure".text = "Blood Pressure: %d mmHg" % blood_pressure
	if digestion == 3:
		$"Control/digestion".text = "Digestion: OFF"


func death():
	print("You're dead.")
	alive = 0
	#global.scores[2] = ["adrenal", score]
	
	global.update_scores("adrenal", score)
	adrenaline.disabled = 1
	
	global.save_scores()
	
func failure():
	print("You've failed.")
	

func _on_adrenaline_button_down() -> void:
	change()


func run():
	
	while alive:
		var tempx = randi_range(0,3)
		var tempy = randi_range(0,3)
		cur_event = tempx
		
		match tempx:
			0:
				event.text = list1[tempy]
			1:
				event.text = list2[tempy]
			2:
				event.text = list3[tempy]
			3:
				event.text = list4[tempy]
				
			
# x -540 : 275
# Y -285 : 225
		
		var posx = randi_range(-540, 275)
		var posy = randi_range(-285, 225)
		
		adrenaline.position.x = posx
		adrenaline.position.y = posy
		
		
		await get_tree().create_timer(waiting_time).timeout
		#if digestion > 5: death()
		adrenaline.disabled = 0
		
		
		
		match tempx:
			0:
				if digestion:
					score += 3;
				else:
					health -= 1;
			1:
				if digestion:
					score += 1
				else:
					score -= 1
			2:
				if !digestion:
					score += 1
				else:
					score -= 1
			3:
				if !digestion:
					score += 3
				else: 
					health -= 1
		if score < 0:
			score = 0
		#match tempx:
			#0:
				#if digestion < 3:
					#death()
			#1: 
				#if digestion < 2:
					#failure()
			#2:
				#if digestion > 1: 
					#failure()
			#3: 
				#if digestion > 1:
					#death()
		
		if health < 1: 
			death()
			
		print(score)
		$Control/score.text = "Score: " + str(score)
		$Control/health.text = "Health: " + str(health)
		
		
		glucose_level = 85
		heart_rate = 70
		blood_pressure = 120
		digestion = 0
		$Control/glucose_level.text = "Glucose Level: %d mg/dL" % glucose_level
		$Control/heart_rate.text = "Heart Rate: %d bpm" % heart_rate
		$"Control/blood pressure".text = "Blood Pressure: %d mmHg" % blood_pressure
		$"Control/digestion".text = "Digestion: ON"
		


func _on_general_timeout() -> void:
	if waiting_time > 1:
		waiting_time -= 1
	

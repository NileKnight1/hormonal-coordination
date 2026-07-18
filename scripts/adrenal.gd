extends Node2D


var cur_event
@onready var event = $Control/event

var glucose_level = 85
var heart_rate = 70
var blood_pressure = 120
var digestion = 1

func _ready() -> void:
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
	glucose_level += 10
	heart_rate += 10
	blood_pressure += 10
	digestion += 1
	$Control/glucose_level.text = "Glucose Level: %d mg/dL" % glucose_level
	$Control/heart_rate.text = "Heart Rate: %d bpm" % heart_rate
	$"Control/blood pressure".text = "Blood Pressure: %d mmHg" % blood_pressure
	if digestion == 3:
		$"Control/digestion".text = "Digestion: OFF"


func death():
	print("You're dead.")
func failure():
	print("You've failed.")
	

func _on_adrenaline_button_down() -> void:
	change()
	
func run():
	
	while 1:
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
		await get_tree().create_timer(5).timeout
		if digestion > 5: death()
		
		match tempx:
			0:
				if digestion < 3:
					death()
			1: 
				if digestion < 2:
					failure()
			2:
				if digestion > 1: 
					failure()
			3: 
				if digestion > 1:
					death()
		
		glucose_level = 85
		heart_rate = 70
		blood_pressure = 120
		digestion = 1
		$Control/glucose_level.text = "Glucose Level: %d mg/dL" % glucose_level
		$Control/heart_rate.text = "Heart Rate: %d bpm" % heart_rate
		$"Control/blood pressure".text = "Blood Pressure: %d mmHg" % blood_pressure
		$"Control/digestion".text = "Digestion: ON"
		

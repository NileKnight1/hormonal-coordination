extends Node2D


@onready var glucose_level_label = $Node/glucose_level
@onready var status = $Node/status
@onready var cooldown = $cooldown
@onready var b1 = $Node/insulin
@onready var b2 = $Node/glucagon

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
	#print(global.scores)
	await get_tree().create_timer(5).timeout
	
	run()

func _process(delta: float) -> void:
	
	if alive:
		if score < 0: 
			return
		elif glucose_level < 60:
			score -= 3
		elif glucose_level < 110:
			score += 2
		elif glucose_level < 140:
			score += 1
		else:
			score -= 2
			
	$Node/score.text = str(score/60)
	
func death():
	print("You're dead")
	b1.disabled = 1
	b2.disabled = 1
	
	
	alive = 0
	#global.scores[1] = ["pancreas", score/60]
	global.update_scores("pancreas", score/60)
	
	print(global.scores)
	global.save_scores()

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
		print(temp)
		
		glucose_level += temp * s
		glucose_level_label.text = "Glucose level: " + str(glucose_level)
		await get_tree().create_timer(1).timeout
	
	if glucose_level < 40:
		death()
	if glucose_level > 300:
		death()

func _on_insulin_button_down() -> void:
	cooldown.start()
	b1.disabled = 1
	b2.disabled = 1
	
	glucose_change(8, -1)


func _on_glucagon_button_down() -> void:
	cooldown.start()
	b1.disabled = 1
	b2.disabled = 1
	
	glucose_change(4, 1)
	


func _on_cooldown_timeout() -> void:
	b1.disabled = 0
	b2.disabled = 0


func _on_general_timeout() -> void:
	if waiting_time > 4:
		waiting_time -= 1

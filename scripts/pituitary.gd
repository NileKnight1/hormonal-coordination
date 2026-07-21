extends Node2D

@onready var status = $Control/status
@onready var timer = $timer
@onready var g_timer = $general

@onready var b1 = $Control/gh
@onready var b2 = $Control/acth
@onready var b3 = $Control/adh
@onready var b4 = $Control/tsh

var hardness = 0
var choosen = -1
var score = 0
var health = 3
var temp_time = -1

func _ready() -> void:
	run()
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

var list_adh = [
	"You've urinated a lot.",
	"Your body lacks water.",
	"Blood pressure is low.",
	"You're sweating so much."
]

var list_tsh = [
	"Your skin is dry.",
	"Weather is cold.",
	"Body metabolism is low.",
	"Glucose needs to be oxidized."
]

var list_acth = [
	"You're long fasting.",
	"You're long fasting.",
	"You're long fasting.",
	"You're long fasting."	
]

var list_gh = [
	"Body needs to grow.",
	"Muscles need recovery.",
	"Body is short.",
	"Bones are small."
]

func run():
	while 1:
		var tempx = randi_range(0,3)
		var tempy = randi_range(0,3)
		
		match tempx:
			0:
				status.text = list_adh[tempy]
			1:
				status.text = list_tsh[tempy]
			2:
				status.text = list_acth[tempy]
			3:
				status.text = list_gh[tempy]
			
		timer.start()
		await timer.timeout
		
		
		if choosen != tempx:
			health -= 1
			$Control/health.text = "Health: " + str(health)
		else:
			print(temp_time)
			if temp_time > 3:
				score += 3
			elif temp_time > 1.5:
				score += 2
			elif temp_time > 0:
				score += 1
		
		if health == 0:
			death()

		
		b1.disabled = 0
		b2.disabled = 0 
		b3.disabled = 0
		b4.disabled = 0
		
		$Control/score.text = "Score: " + str(score)
		
		print("Score:")
		print(score)
		choosen = -1
		temp_time = -1
	
func death():
	print("death")

func pressed():
	#print(int(timer.time_left))
	
	b1.disabled = 1
	b2.disabled = 1 
	b3.disabled = 1
	b4.disabled = 1
	
	temp_time = timer.time_left
	#timer.emit_signal("timeout") 
	#timer.stop()
	

func _on_adh_button_down() -> void:
	choosen = 0
	pressed()

func _on_tsh_button_down() -> void:
	choosen = 1
	pressed()

func _on_acth_button_down() -> void:
	choosen = 2
	pressed()

func _on_gh_button_down() -> void:
	choosen = 3
	pressed()
	


func _on_timer_timeout() -> void:
	hardness += 1

extends Node2D


@onready var status = $Control/status
@onready var b1 = $Control/calcitonin
@onready var b2 = $Control/parathormone
@onready var cooldown = $cooldown

var alive = 1
var calcium_level = 95.0
var score = 0
var waiting_time = 10

var ca_inc = [
	["You're drinking milk.", 6],
	["You're eating fish.", 4],
	["You're having cheese.", 3],
	["You're taking calcium supplement.", 8],
]

var ca_dec = [
	["You're doing light exercise.", 6],
	["You're doing intense exercise.", 4],
	["You have excessive urination.", 3],
]


func change_calcium(x, s):
	var temp
	var sum = 0
	
	print("X before while " + str(x))
	#print("Ca before " + str(calcium_level))	
	#print("X before while " + str(x))
	
	
	while x:
		#calcium_level *= 10
		temp = randi_range(1, x)
		x -= temp
		#print(temp)
		#print("X " + str(x))
		
		#calcium_level *= 10
		#print("Ca before " + str(calcium_level))

		
		calcium_level += temp * s
		#calcium_level /= 10
		#print("Ca after " + str(calcium_level))

		
		
		$Control/calcium_level.text = "Blood Ca⁺²: %.1f mg/dL" % (calcium_level/10)
		await get_tree().create_timer(1).timeout
	
	print("Ca end " + str(calcium_level))
	
	if calcium_level < 70:
		death()
	if calcium_level > 125:
		death()

func death():
	print("You're dead.")
	alive = 0
	#global.scores[0] = ["thyroid", score/60]
	global.update_scores("thyroid", score/60)

	
	b1.disabled = 1
	b2.disabled = 1
	
	global.save_scores()


func _ready() -> void:
	change_calcium(0, 1)
	run()
	pass 

func _process(delta: float) -> void:
	
	if alive:
		if score < 0:
			return
		elif calcium_level < 80:
			score -= 3
		elif calcium_level < 105:
			score += 2
		elif calcium_level < 115:
			score += 1
		else:
			score -= 2
			
		$Control/score.text = str(score/60)

func run():
	await get_tree().create_timer(3).timeout
	while alive:
		var temp = randi_range(0,1)
		
		if !temp:
			status.text = ca_inc[temp][0]
			await get_tree().create_timer(1).timeout
			status.text = ""
			
			temp = randi_range(0, len(ca_inc)-1)
			change_calcium(ca_inc[temp][1],1)
		else:
			status.text = ca_dec[temp][0]
			await get_tree().create_timer(1).timeout
			status.text = ""
			
			temp = randi_range(0, len(ca_dec)-1)
			change_calcium(ca_dec[temp][1],-1)
		await get_tree().create_timer(waiting_time).timeout

func _on_calcitonin_button_down() -> void:
	cooldown.start()
	b1.disabled = 1
	b2.disabled = 1
	change_calcium(2, -1)

func _on_parathormone_button_down() -> void:
	cooldown.start()
	b1.disabled = 1
	b2.disabled = 1
	change_calcium(2, 1)
#
#func milk():
	#status.text = "Player drank milk."
	#await get_tree().create_timer(1).timeout
	#change_calcium(0.6)
#
#func cheese():
	#status.text = "Player ate cheese."
	#await get_tree().create_timer(1).timeout
	#
	#change_calcium(0.4)
#
#func exercise():
	#status.text = "Player did exercise."
	#await get_tree().create_timer(1).timeout
	#
	#change_calcium(-0.3)
#
#func urination():
	#status.text = "Player has excessive urination."
	#await get_tree().create_timer(1).timeout
	#
	#change_calcium(-0.2)


func _on_timer_timeout() -> void:
	b1.disabled = 0
	b2.disabled = 0

func _on_general_timeout() -> void:
	if waiting_time > 1.5:
		waiting_time -=1

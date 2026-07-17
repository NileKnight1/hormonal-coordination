extends Node2D


@onready var glucose_level_label = $Node/glucose_level
@onready var status_label = $Node/status

var glucose_level = 0


#
#func wait(x):
	#await get_tree().create_timer(x).timeout


func _ready() -> void:
	glucose_change(85)
	run()
	
func death():
	print("You're dead")

func run():
	while true:
		var temp = randi_range(0,3)
		
		match temp:
			0:
				await exercise()
			1:
				await fasting()
			2:
				await fastfood()
			3:
				await eating()
		
		await get_tree().create_timer(5).timeout
		
	
func glucose_change(x):
	glucose_level += x
	glucose_level_label.text = "Glucose level: " + str(glucose_level)
	if glucose_level < 0:
		death()
	if glucose_level > 500:
		death()

func _on_insulin_button_down() -> void:
	glucose_change(-8)


func _on_glucagon_button_down() -> void:
	glucose_level_label.text = "Glucose level: " + str(glucose_level + 5)
	glucose_change(4)
	
func eating():
	status_label.text = "Player is eating."
	for x in range(5):
		await get_tree().create_timer(2).timeout
		glucose_change(10)

func fasting():
	status_label.text = "Player is fasting."
	
	for x in range(5):
		await get_tree().create_timer(3).timeout
		glucose_change(-5)

func fastfood():
	status_label.text = "Player is eating fast food."
	
	for x in range(5):
		await get_tree().create_timer(1).timeout
		glucose_change(+15)

func exercise():
	status_label.text = "Player is doing exercise."
	
	for x in range(7):
		await get_tree().create_timer(2).timeout
		glucose_change(-5)

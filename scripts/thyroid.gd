extends Node2D

var calcium_level = 0
@onready var status = $Control/status

func change_calcium(x):
	calcium_level += x
	$Control/calcium_level.text = "Blood Calcium Level: %.1f mg/dL" % calcium_level
	
	if calcium_level < 7:
		death()
	if calcium_level > 12.5:
		death()

func death():
	print("You're dead.")

func _ready() -> void:
	change_calcium(9.5)
	run()
	pass 

func run():
	await get_tree().create_timer(3).timeout
	while 1:
		await get_tree().create_timer(2).timeout
		var temp = randi_range(0,3)
		
		match temp:
			0:
				await milk()
			1:
				await cheese()
			2:
				await exercise()
			3:
				await urination()


func _on_calcitonin_button_down() -> void:
	change_calcium(-0.2)


func _on_parathormone_button_down() -> void:
	change_calcium(0.2)

func milk():
	status.text = "Player drank milk."
	await get_tree().create_timer(1).timeout
	change_calcium(0.6)

func cheese():
	status.text = "Player ate cheese."
	await get_tree().create_timer(1).timeout
	
	change_calcium(0.4)

func exercise():
	status.text = "Player did exercise."
	await get_tree().create_timer(1).timeout
	
	change_calcium(-0.3)

func urination():
	status.text = "Player has excessive urination."
	await get_tree().create_timer(1).timeout
	
	change_calcium(-0.2)

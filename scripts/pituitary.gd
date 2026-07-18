extends Node2D

@onready var status = $Control/status
var choosen = -1

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
	
		await get_tree().create_timer(5).timeout
		
		if choosen != tempx:
			fail()
		
		choosen = -1
	
func fail():
	print("failed")

func _on_adh_button_down() -> void:
	choosen = 0

func _on_tsh_button_down() -> void:
	choosen = 1

func _on_acth_button_down() -> void:
	choosen = 2

func _on_gh_button_down() -> void:
	choosen = 3

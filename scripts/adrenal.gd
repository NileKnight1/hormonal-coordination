extends Node2D


var glucose_level = 85
var cur_event
@onready var event = $Control/event

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

func death():
	print("You're dead.")
	
func _on_adrenaline_button_down() -> void:
	print("hoho")
	
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
				

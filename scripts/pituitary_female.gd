extends Node2D

@onready var status = $Control/status
var choosen = -1

func _ready() -> void:
	run()

func _process(delta: float) -> void:
	pass

var list = [
	"Body needs a graffian follicle.",
	"Body needs an ovum.",
	"The body is delivering.",
	"Body needs to produce milk."
]

func run():
	while 1:
		var tempx = randi_range(0,3)
		
		status.text = list[tempx]

		await get_tree().create_timer(5).timeout
		
		if choosen != tempx:
			fail()
		
		choosen = -1
	
func fail():
	print("failed")


func _on_fsh_button_down() -> void:
	choosen = 0
func _on_lh_button_down() -> void:
	choosen = 1
func _on_oxytocin_button_down() -> void:
	choosen = 2
func _on_prolactin_button_down() -> void:
	choosen = 3

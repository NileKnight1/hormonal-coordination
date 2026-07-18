extends Node2D

@onready var status = $Control/status
var choosen = -1

func _ready() -> void:
	run()

func _process(delta: float) -> void:
	pass

var list = [
	"Body needs sperms.",
	"Body needs testosterone."
]

func run():
	while 1:
		var tempx = randi_range(0,1)
		
		status.text = list[tempx]

		await get_tree().create_timer(5).timeout
		
		if choosen != tempx:
			fail()
		
		choosen = -1
	
func fail():
	print("failed")

func _on_lh_button_down() -> void:
	choosen = 1

func _on_fsh_button_down() -> void:
	choosen = 0

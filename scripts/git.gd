extends Node2D

@onready var status = $Control/status

var choice = -1

func _ready() -> void:
	run()

var list = [
	"Food entered the stomach.",
	"Food entered the small intestine.",
	"Food contains lipids."
]

func run():
	while 1:
		var tempx = randi_range(0,2)
		status.text = list[tempx]

		await get_tree().create_timer(5).timeout
		if choice != tempx:
			fail()
			
		choice = -1

func fail():
	print("failed")

func _on_gastrin_button_down() -> void:
	choice = 0

func _on_secretin_button_down() -> void:
	choice = 1

func _on_cck_button_down() -> void:
	choice = 2

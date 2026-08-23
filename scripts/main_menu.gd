extends Node2D

var click = preload("res://audio/click.wav")
var collect = preload("res://audio/collect.mp3")

@onready var bg = $CanvasLayer/bg

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_sound(sound):
	var temp = AudioStreamPlayer.new()
	temp.stream = sound
	add_child(temp)
	
	temp.finished.connect(temp.queue_free)
	temp.play()
	

func _on_glands_button_down() -> void:
	play_sound(click)
	$CanvasLayer/main.visible = 0
	$CanvasLayer/glands.visible = 1


func _on_back_button_down() -> void:
	play_sound(click)
	
	$CanvasLayer/main.visible = 1
	$CanvasLayer/glands.visible = 0
	$CanvasLayer/scores.visible = 0
	

func move(dis):
	bg.modulate.a = 0.0
	bg.visible = 1
	create_tween().tween_property(bg, "modulate:a", 1.0, 0.3)
	
	
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file(dis)


func _on_pancreas_button_down() -> void:
	play_sound(collect)
	move("res://scenes/pancreas.tscn")
func _on_pituitary_button_down() -> void:
	play_sound(collect)
	move("res://scenes/pituitary.tscn")
func _on_thyroid_button_down() -> void:
	play_sound(collect)
	move("res://scenes/thyroid.tscn")
func _on_adrenal_button_down() -> void:
	play_sound(collect)
	move("res://scenes/adrenal.tscn")
func _on_general_button_down() -> void:
	play_sound(collect)
	move("res://scenes/general.tscn")


func _on_scores_button_down() -> void:
	play_sound(click)
	$CanvasLayer/main.visible = 0
	$CanvasLayer/scores.visible = 1
	
func update():
	$CanvasLayer/scores/pancreas.text = "Pancreas: " + str(global.scores["pancreas"])
	$CanvasLayer/scores/thyroid.text = "Thyroid: " + str(global.scores["thyroid"])
	$CanvasLayer/scores/adrenal.text = "Adrenal: " + str(global.scores["adrenal"])
	$CanvasLayer/scores/pituitary.text = "Pituitary: " + str(global.scores["pituitary"])
	$CanvasLayer/scores/pituitary.text = "General: " + str(global.scores["general"])
	
	#$sex.text = "Sex: " + str(global.scores)

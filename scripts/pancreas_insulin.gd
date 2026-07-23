extends Node2D

var ind = 0
var speed = 100


var path = [
	Vector2(85, 142),
	Vector2(104, 255),
	Vector2(121, 344)
]


func _process(delta: float) -> void:
	if ind == path.size():
		queue_free()
		return
		
	var target = path[ind]
	
	position = position.move_toward(target, speed * delta)
	if position.distance_to(target) < 5:
		ind += 1

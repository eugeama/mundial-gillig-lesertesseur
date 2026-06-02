extends Area2D

@export var SPEED = 400
var carril: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += SPEED * delta	
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()
		
func puntaje(zona: Area2D)-> float:
	var perfecto = zona.get_node("perfect")
	var bien= zona.get_node("great")
	var bueno= zona.get_node("good")
	var medio= zona.get_node("barely")
	
	if perfecto.get_overlapping_areas().has(self):
		return 3
	elif bien.get_overlapping_areas().has(self):
		return 2
	elif bueno.get_overlapping_areas().has(self):
		return 1
	else:
		return 0.5

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
	var puntajes= ["perfect", "great", "good", "barely"]
	
	for puntos in puntajes:
		var tipoNota= zona.get_node(puntos)
		var mitadNota= tipoNota.shape.size * tipoNota.scale/2
		var distanciaDeCentro= (position - zona.global_position).abs()
		if distanciaDeCentro.x <= mitadNota.x and distanciaDeCentro.y <= mitadNota.y:
			if puntos == "perfect":
				return 3
			elif puntos== "great":
				return 2
			elif puntos== "good":
				return 1
	return 0.5
		

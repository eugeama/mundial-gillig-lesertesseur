extends Node2D

@export var notas = "res://scripts/note.gd"
const LANES={
	"notaD": 148,
	"notaF": 390,
	"notaJ": 624,
	"notaK": 884
}

func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnNote():
	var lane = chooseLane()
	var nuevaNota = notas.instantiate()
	nuevaNota.position.x = LANES[lane]
	nuevaNota.carril = lane
	add_child(nuevaNota)
	
func chooseLane():
	var lane = LANES.keys()[randi_range(0, LANES.size() - 1)]
	return lane

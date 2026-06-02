extends Node2D

@export var notas : PackedScene
const LANES={
	"notaD": 148,
	"notaF": 390,
	"notaJ": 624,
	"notaK": 884
}

const tipoNotas=[
	[1,0,2,1],
	[0,2,0,1],
	[1,0,0,2],
	[0,1,2,0]
]

var patron_actual = []
var beat_en_medida = 0

func _ready() -> void:
	Conductor.beatMandar.connect(_on_conductor_beat_mandar)
	Conductor.medidaMandar.connect(_on_conductor_medida_mandar)
	Conductor.esperar(2)
	
func _process(delta: float) -> void:
	pass

func _on_conductor_beat_mandar(position) -> void:
	if patron_actual.is_empty():
		return
	var tipo = patron_actual[beat_en_medida]
	if tipo == 1:
		mostrarNota()
	elif tipo == 2:
		mostrarNota()
		mostrarNota()
	beat_en_medida += 1
	if beat_en_medida >= patron_actual.size():
		beat_en_medida = 0

func _on_conductor_medida_mandar(position) -> void:
	patron_actual = tipoNotas[randi_range(0, tipoNotas.size() - 1)]
	beat_en_medida= 0

func mostrarNota():
	var lane = carrilQueAparece()
	var nuevaNota = notas.instantiate()
	nuevaNota.position.x = LANES[lane]
	nuevaNota.carril = lane
	add_child(nuevaNota)
	
func carrilQueAparece():
	var lane = LANES.keys()[randi_range(0, LANES.size() - 1)]
	return lane

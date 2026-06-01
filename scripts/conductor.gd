extends AudioStreamPlayer2D

@export var bpm= 0
@export var medidas= 0

var posicion= 0.0
var posicion_en_beats= 1
var segundos_beat= 0
var ultimo_beat= 0
var beat_antes_empezar= 0
var medida= 1

signal beatMandar(position)
signal medidaMandar(position)

func elegirNivel(nivel: String) -> void:
	var niveles=load("res://scripts/niveles.gd")
	var nivelElegido= niveles.NIVELES[nivel]
	bpm= nivelElegido["bpm"]
	medidas= nivelElegido["medidas"]
	$AudioStreamPlayer2D.stream = nivelElegido["cancion"]

func _ready() -> void:
	elegirNivel("")
	segundos_beat = 60/bpm
	$AudioStreamPlayer2D.play()

func _physics_process(_delta):
	if playing:
		posicion= get_playback_position() + AudioServer.get_time_since_last_mix()
		posicion-= AudioServer.get_output_latency()
		posicion_en_beats = int(floor(posicion / posicion_en_beats)) + beat_antes_empezar
		mandarBeat()

func mandarBeat():
	if ultimo_beat < posicion_en_beats:
		if medida > medidas:
			medida= 1
		emit_signal("beatMandar", posicion_en_beats)
		emit_signal("medidaMandar", medida)
		ultimo_beat= posicion_en_beats
		medida+= 1

func _process(delta: float) -> void:
	pass

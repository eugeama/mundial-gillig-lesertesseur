extends AudioStreamPlayer2D

@export var bpm= 0
@export var medidas= 0

var posicion= 0.0
var posicion_en_beats= 1
var segundos_beat= 0
var ultimo_beat= 0
var beat_antes_empezar= 0
var medida= 1
var tiempo= 0

signal beatMandar(position)
signal medidaMandar(position)
signal terminarNivel()

func elegirNivel(nivel: String) -> void:
	bpm= 0
	medidas= 0
	posicion= 0.0
	posicion_en_beats= 1
	segundos_beat= 0
	ultimo_beat= 0
	beat_antes_empezar= 0
	medida= 1
	tiempo= 0
	
	var niveles=preload("res://scripts/niveles.gd")
	var nivelesElegir = niveles.new()  
	var nivelElegido= nivelesElegir.NIVELES[nivel]
	bpm= nivelElegido["bpm"]
	medidas= nivelElegido["medida"]
	stream = load(nivelElegido["cancion"])
	tiempo= nivelElegido["tiempo"]
	segundos_beat = 60.0/bpm
	await get_tree().create_timer(tiempo).timeout
	terminarNivel.emit()
	
func _ready() -> void:
	if stream != null:
		play()

func _physics_process(_delta):
	if playing:
		posicion= get_playback_position() + AudioServer.get_time_since_last_mix()
		posicion-= AudioServer.get_output_latency()
		posicion_en_beats = int(floor(posicion / segundos_beat)) + beat_antes_empezar
		mandarBeat()

func mandarBeat():
	if ultimo_beat < posicion_en_beats:
		if medida > medidas:
			medida= 1
		emit_signal("beatMandar", posicion_en_beats)
		emit_signal("medidaMandar", medida)
		ultimo_beat= posicion_en_beats
		medida+= 1
		
func esperar(tiempo_espera):
	beat_antes_empezar= tiempo_espera
	$Timer.wait_time= segundos_beat
	$Timer.start()
	play()

func arreglarDelay():
	posicion_en_beats+=1
	if posicion_en_beats < beat_antes_empezar -1:
		$Timer.start()
	elif posicion_en_beats == beat_antes_empezar - 1:
		$Timer.wait_time= $Timer.wait_time - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())
		$Timer.start()
	else:
		play()
		$Timer.stop()
	mandarBeat()

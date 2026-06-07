extends Node2D

@onready var noteSpawner= $NoteSpawner
@onready var hitZones= $HitZones

var puntajeF=0
var comboF=0

const LANE_KEYS = {
	"dKey": "notaD",
	"fKey": "notaF",
	"jKey": "notaJ",
	"kKey": "notaK"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Conductor.terminarNivel.connect(_on_terminar_nivel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	input()
	checkMiss()

func input():
	for key in LANE_KEYS.keys():
		if Input.is_action_just_pressed(key):
			checkHit(key)
		
		
func checkHit(key: String):
	var carril = LANE_KEYS[key]
	var zone = hitZones.get_node(carril)
	if zone == null:
		return
		
	if zone.monitoring == false:
		return
		
	var overlapping = zone.get_overlapping_areas()
	
	for nota in overlapping:
		if nota.carril == carril:
			puntajeF+=nota.puntaje(zone)
			comboF+=1
			actualizarPuntosYCombo()
			nota.queue_free()
			$hitSFX.play()
			return
	
func checkMiss():
	for child in noteSpawner.get_children():
		if child is Node2D and child.position.y > get_viewport_rect().size.y + 5:
			comboF=0
			actualizarPuntosYCombo()
			$missSFX.play()
			child.queue_free()
			
func _on_terminar_nivel() -> void:
	get_tree().change_scene_to_file("res://scenes/terminar.tscn")
	
func actualizarPuntosYCombo()-> void:
	$LabelPuntos.text = "Puntos: " + str(puntajeF)
	$LabelCombo.text= "Combo: "+ str(comboF)
	

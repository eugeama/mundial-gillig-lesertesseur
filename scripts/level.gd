extends Node2D

@onready var noteSpawner = $NoteSpawner
@onready var hitZones = $HitZones

const LANE_KEYS = {
	"dKey": "notaD",
	"fKey": "notaF",
	"jKey": "notaJ",
	"kKey": "notaK"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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
			calcularPuntaje(nota.puntaje(zone))
			nota.queue_free()
			$hitSFX.play()
			return
	
func checkMiss():
	for child in noteSpawner.get_children():
		if child is Node2D and child.position.y > get_viewport_rect().size.y + 5:
			print("checkMiss() -> MISS")
			$missSFX.play()
			child.queue_free()
			
func calcularPuntaje(puntaje: float):
	pass #me falta hacer el metodo pero lo hago el finde bue pero basicamente es un coso que te calcula combo 
	#y te va sumando puntatje. para no teener todo en checkhit. t digo por si te dan ganas de hacerlo euugew
	

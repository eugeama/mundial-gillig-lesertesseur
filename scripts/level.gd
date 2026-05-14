extends Node2D

@onready var noteSpawner = $NoteSpawner
@onready var hitZones = $HitZones

const LANE_KEYS = {
	"dKey": "d",
	"fKey": "f",
	"jKey": "j",
	"kKey": "k"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	input()

func input():
	var zone = hitZones.get_node()
	if Input.is_action_just_pressed("dKey") and checkHit(zone):
		print("input() -> hit")

func checkHit(zone: Area2D):
	var hit = false
	var overlapping = zone.get_overlapping_areas()

	if overlapping.is_empty():
		print("checkHit() -> overlapping.is_empty()")
	else:
		hit = true	
	return hit
	

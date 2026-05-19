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
	#var zone = hitZones.get_node()
	if Input.is_action_just_pressed("dKey") or Input.is_action_just_pressed("fKey") or Input.is_action_just_pressed("jKey") or Input.is_action_just_pressed("kKey"):
		#print("input() -> Input.is_action_just_pressed(dKey)")
		checkHit()
		
func checkHit():
	for zone in hitZones.get_children():
		var overlapping = zone.get_overlapping_areas()
		if !overlapping.is_empty():
			print("HIT")
			return
	print("MISS")

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
	checkMiss()

func input():
	#var zone = hitZones.get_node()
	if Input.is_action_just_pressed("dKey") or Input.is_action_just_pressed("fKey") or Input.is_action_just_pressed("jKey") or Input.is_action_just_pressed("kKey"):
		#print("input() -> Input.is_action_just_pressed(dKey)")
		checkHit()
		
func checkHit():
	for zone in hitZones.get_children():
		var overlapping = zone.get_overlapping_areas()
		if !overlapping.is_empty():
			print("checkHit() -> HIT")
			return
	print("checkHit() -> MISS")
	
func checkMiss():
	for child in noteSpawner.get_children():
		if child is Node2D and child.position.y > get_viewport_rect().size.y + 5:
			print("checkMiss() -> MISS")
			child.queue_free()
			

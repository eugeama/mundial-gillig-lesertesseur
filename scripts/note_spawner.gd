extends Node2D

@export var noteScene: PackedScene
@onready var spawnTimer = $spawnTimer

const LANES={
	1: 148,
	2: 390,
	3: 624,
	4: 884
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnTimer.wait_time = randf_range(0.5, 1.2)
	spawnTimer.timeout.connect(spawnNote)
	spawnTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnNote():
	var lane = chooseLane()
	var newNote = noteScene.instantiate()
	newNote.position.x = LANES[lane]
	add_child(newNote)
	spawnTimer.wait_time = randf_range(0.5, 1.2)
	spawnTimer.start()
	
func chooseLane():
	var lane = randi_range(1,4)
	return lane

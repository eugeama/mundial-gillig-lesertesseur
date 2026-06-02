extends Control

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func irANivel():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	
func _on_fireball_pressed() -> void:
	Conductor.elegirNivel("fireball")
	$dale.play()
	await get_tree().create_timer(1).timeout
	irANivel()
	
func _on_ikywm_pressed() -> void:
	Conductor.elegirNivel("ikywm")
	$dale.play()
	await get_tree().create_timer(1).timeout
	irANivel()
	
func _on_timber_pressed() -> void:
	Conductor.elegirNivel("timber")
	$dale.play()
	await get_tree().create_timer(1).timeout
	irANivel()
	
func _on_eltaxi_pressed() -> void:
	Conductor.elegirNivel("el_taxi")
	$dale.play()
	await get_tree().create_timer(1).timeout
	irANivel()


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

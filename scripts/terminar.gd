extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer2/LabelPuntajeF.text= "puntaje final: "+ str(PuntosYCombos.puntos)
	$VBoxContainer2/LabelComboF.text= "mejor combo: "+str(PuntosYCombos.combos)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menuNiveles.tscn")

func _on_menu_principal_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

extends Node2D

export var color_number: int = 1

func _ready():
	var img_name: String = str("%02d" % color_number)
	var img_texture_path := "res://res/" + img_name + ".tres"
	var img_texture: AtlasTexture = load(img_texture_path)
	$Sprite.texture = img_texture


func _on_SelectionArea2D_selection_toggled(selection):
		print("choice selection toggled, name = " + str(name) + ", selected = " + str(selection))
		if selection:
			get_tree().call_group("choice_listeners", "_on_choice_selected", $Sprite.texture, color_number)

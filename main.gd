extends Node2D

export var selected_texture: Texture
var selected_color_number: int

var peg_colors = {}
var peg_names = ["peg1", "peg2", "peg3", "peg4"]
var default_peg_color = 13

var max_attempts = 8
var attemps = 1
 
func _ready():
	add_to_group("peg_listeners")
	add_to_group("choice_listeners")
	for i in peg_names:
		peg_colors[i] = default_peg_color
	

func _on_choice_selected(texture: Texture, color_number: int):
	selected_texture = texture
	selected_color_number = color_number
	print("_on_choice_selected, color_number = " + str(selected_color_number))

func _on_peg_selected(peg_name: String, sprite: Sprite):
	sprite.texture = selected_texture
	peg_colors[peg_name] = selected_color_number
	print("_on_peg_selected " + str(peg_name))

func _on_checkbutton_pressed():
	for i in peg_names:
		print(str(i) + "=" + str(peg_colors.get(i)))

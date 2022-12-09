extends Node2D

export var selected_texture: Texture

const peg_scene = preload("res://peg.tscn")
const btn_scene = preload("res://checkbutton.tscn")


var selected_color_number: int
var default_peg_color = 13
var peg_colors = {}
var peg_names = []
var hidden_colors_list = [8,14,16,18,22,26,28,29,31]
var hidden_colors = []

var guesses = 0
var max_guesses = 7

var peg_positions = {}
#	"1peg1" : Vector2(320,64),
#	"1peg2" : Vector2(384,64),
#	"1peg3" : Vector2(448,64),
#	"1peg4" : Vector2(512,64)	
#}
 
func _ready():
	randomize()
	_pick_hidden_colors()
	add_to_group("peg_listeners")
	add_to_group("choice_listeners")
	for i in range(0, max_guesses):
		var offset = Vector2(0, (i*66))
		print(str(offset))
		var key1 = str(i) + "peg1" 
		var key2 = str(i) + "peg2" 
		var key3 = str(i) + "peg3" 
		var key4 = str(i) + "peg4" 	
		peg_positions[key1] = Vector2(320, 64) + offset
		peg_positions[key2] = Vector2(384, 64) + offset
		peg_positions[key3] = Vector2(448, 64) + offset
		peg_positions[key4] = Vector2(512, 64) + offset
	_create_pegs()
	_create_checkbutton()


func _pick_hidden_colors():
	for _i in range(0,4):
		hidden_colors.append(hidden_colors_list[randi() % 9])


func _create_pegs():
	for i in peg_positions.keys():
		var peg = peg_scene.instance()
		peg.name = i
		peg.position = peg_positions.get(i)
		add_child(peg)	

func _create_checkbutton():
	var btn = btn_scene.instance()
	btn.set_global_position(Vector2(96,256))
	btn.connect("pressed", self, "_on_checkbutton_pressed")
	add_child(btn) 	

func _on_choice_selected(texture: Texture, color_number: int):
	selected_texture = texture
	selected_color_number = color_number
	print("_on_choice_selected, color_number = " + str(selected_color_number))

func _on_peg_selected(peg_name: String, sprite: Sprite):
	sprite.texture = selected_texture
	peg_colors[peg_name] = selected_color_number
	print("_on_peg_selected " + str(peg_name))

func _on_checkbutton_pressed():
	#for i in peg_positions.keys():
	#	print(str(i) + "=" + str(peg_colors.get(i)))

	var key1 = str(guesses) + "peg1" 
	var key2 = str(guesses) + "peg2" 
	var key3 = str(guesses) + "peg3" 
	var key4 = str(guesses) + "peg4" 	

	var guess1 = peg_colors[key1]
	var guess2 = peg_colors[key2]
	var guess3 = peg_colors[key3]
	var guess4 = peg_colors[key4]

	print("guess 1 = " + str(guess1) + ", hidden1 = " +  str(hidden_colors[0]))
	print("guess 2 = " + str(guess2) + ", hidden2 = " +  str(hidden_colors[1]))
	print("guess 3 = " + str(guess3) + ", hidden3 = " +  str(hidden_colors[2]))
	print("guess 4 = " + str(guess4) + ", hidden4 = " +  str(hidden_colors[3]))	


	var indicators = {}
	if guess1 == hidden_colors[0]:
		indicators["indicator1"] = Color.green
	elif guess1 == hidden_colors[1] or guess1 == hidden_colors[2] or guess1 == hidden_colors[3]:
		indicators["indicator1"] = Color.orange
	else:
		indicators["indicator1"] = Color.red

	if guess2 == hidden_colors[1]:
		indicators["indicator2"] = Color.green
	elif guess2 == hidden_colors[0] or guess2 == hidden_colors[3] or guess2 == hidden_colors[3]:
		indicators["indicator2"] = Color.orange
	else:
		indicators["indicator2"] = Color.red

	if guess3 == hidden_colors[2]:
		indicators["indicator3"] = Color.green
	elif guess3 == hidden_colors[0] or  guess3 == hidden_colors[1] or  guess3 == hidden_colors[3]:
		indicators["indicator3"] = Color.orange
	else:
		indicators["indicator3"] = Color.red
	
	if guess4 == hidden_colors[3]:
		indicators["indicator4"] = Color.green
	elif guess4 == hidden_colors[0] or guess4 == hidden_colors[1] or guess4 == hidden_colors[2]:
		indicators["indicator4"] = Color.orange
	else:
		indicators["indicator4"] = Color.red
	
	$indicator_row/indicator1.color = indicators["indicator1"]
	$indicator_row/indicator2.color = indicators["indicator2"]
	$indicator_row/indicator3.color = indicators["indicator3"]
	$indicator_row/indicator4.color = indicators["indicator4"]

	guesses = guesses + 1

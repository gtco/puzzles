extends Node2D

func _on_SelectionArea2D_selection_toggled(selection):
		print("peg selection toggled, name = " + str(name) + ", selected = " + str(selection))
		if selection:
			get_tree().call_group("peg_listeners", "_on_peg_selected", name, $Sprite)

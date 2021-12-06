extends Node
func _ready():
	global.audio=get_node("audio")

func _on_back_pressed():
	global.splay(global.sback)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://menu.tscn")

func _on_sett_pressed():
	global.splay(global.ssett)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://sett.tscn")



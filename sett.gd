extends Node

var full=0

func _ready():
	global.splay(global.sback)
	get_node("TabContainer/General/Options/CheckBox").set_pressed(OS.window_fullscreen)


func _on_CheckBox_toggled(on):
		if on:
			OS.window_fullscreen =1
		else:
			OS.window_fullscreen =0

func _on_screen_tree_exiting():
	global.save_settings()


func _on_menu_pressed():
	get_tree().change_scene("res://menu.tscn")

extends Node

var full=0
var ignore = null

func _ready():
	global.splay(global.sback)
	get_node("TabContainer/General/Options/CheckBox").set_pressed(OS.window_fullscreen)
	
	if global.gamelistseperate:
		get_node("TabContainer/General/Options/SeperatePacks").set_pressed(true)

func _on_CheckBox_toggled(on):
		if on:
			OS.window_fullscreen =1
		else:
			OS.window_fullscreen =0

func _on_screen_tree_exiting():
	global.save_settings()


func _on_menu_pressed():
	ignore = get_tree().change_scene("res://menu.tscn")


func _on_Seperate_Packs_toggled(on):
	if on:
		global.gamelistseperate=1
	else:
		global.gamelistseperate=0

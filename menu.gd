extends Node
var btnno=[]
var menupos=0

func _ready():
	global.splay(global.sback)
	createmenu()
	cyclemenu(null,0)
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		global.splay(global.sback)
		get_tree().quit() # default behavior
	elif event.is_action_pressed("ui_up"):
		cyclemenu("up",null)
	elif event.is_action_pressed("ui_down"):
		cyclemenu("down",null)
	elif event.is_action_pressed("ui_accept"):
		launch(menupos)

func createmenu():
	btnno.resize(0)
	for i in global.gamestot:
		var item=gamedetails(i)
		print(item[0])
		btnno.append(Button.new())
		get_node("split/ScrollContainer/mainmenu").add_child(btnno[i])
		btnno[i].set_text(item[0])
		btnno[i].set_flat(true)
		btnno[i].connect("pressed", self, "_menu"+str(i)+"_pressed")
		btnno[i].connect("hover", self, "_menu"+str(i)+"_hover")

func _process(delta):		
	for i in global.gamestot:
		if btnno[i].is_hovered():
			cyclemenu(null,i)

		if btnno[i].is_pressed():
			launch(i)
			
		
		
			

func launch(i):
	var item=gamedetails(i)
	OS.execute("steam", ["-applaunch",item[12]], true) 

func gamedetails(i):
	var item
	item=global.gamelist[i].split(",")
	return item

func cyclemenu(direct,i):
	if direct=="up":
		if menupos==0:
			menupos=global.gamestot-1
		else:
			menupos=menupos-1
		i=menupos
	elif direct=="down":
		if menupos==global.gamestot-1:
			menupos=0
		else:
			menupos=menupos+1
		i=menupos
	else:
		menupos=i
		
	var item=gamedetails(i)
	if !get_node("split/right/desc").get_text()==item[2].replacen("&#x2c;",","):
		print(i)
		colorbtn(i)
		get_node("split/right/pack").set_text(item[1])
		get_node("split/right/desc").set_text(item[2].replacen("&#x2c;",","))
		print("res://media/Pictures/"+str(item[9])+".png")
		get_node("split/right/icon").set_texture(load("res://media/Pictures/"+str(item[9])+".png"))
		get_node("split/right/players").set_text("From "+item[10]+" to "+item[11]+" Players")
		get_node("split/ScrollContainer").ensure_control_visible(btnno[i])
	
func colorbtn(j):
	var item
	item = gamedetails(j)
	
	for i in global.gamestot:
		btnno[i].add_color_override("font_color", Color(item[4]))
		item = gamedetails(j)
		
	btnno[j].add_color_override("font_color", Color(item[6]))
	btnno[j].add_color_override("font_color_hover", Color(item[6]))
	
	get_node("background").set_frame_color(Color(item[3]))
	
	get_node("split/right/pack").add_color_override("font_color", Color(item[7]))
	
	get_node("split/right/desc").add_color_override("font_color", Color(item[5]))
	
	get_node("split/right/players").add_color_override("font_color", Color(item[7]))
	
	print(j)


func _on_sett_pressed():
	global.splay(global.ssett)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://sett.tscn")



func _on_rand_pressed():
	cyclemenu(null,randi()%(global.gamestot+1))
	


extends Node
var btnno=[]
var btngame=[]
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
	btngame.resize(0)
	for i in global.gamestot:
		var item=global.gamedetails(i)
		if (!global.gamelistseperate) or (item[1]==global.packlist[global.currentpack]):
			print(item[0] + " Added to Menu")
			btnno.append(Button.new())
			btngame.append(i)
			get_node("split/ScrollContainer/mainmenu").add_child(btnno[-1])
			btnno[-1].set_text(item[0])
			btnno[-1].set_flat(true)
			btnno[-1].connect("pressed", self, "_menu"+str(btnno.size())+"_pressed")
			btnno[-1].connect("hover", self, "_menu"+str(btnno.size())+"_hover")
		else:
			print(item[0] + " Skipped")
	
	if global.gamelistseperate:
		get_node("PackHeadder").show()
		get_node("PackHeadder/CurrentPack").set_text(global.packlist[global.currentpack])
		
		#get_node("split").set_anchor_and_margin(MARGIN_TOP:100,)
		
	else:
		
		
		get_node("PackHeadder").hide()

func deletemenu():
	for i in btnno.size():
		btnno[i].queue_free()

func _process(delta):		
	for i in btnno.size():
		if btnno[i].is_hovered():
			cyclemenu(null,i)

		if btnno[i].is_pressed():
			launch(btngame[i])
			
		
		
			

func launch(i):
	var item=global.gamedetails(i)
	OS.execute("steam", ["-applaunch",item[12]], true) 



func cyclemenu(direct,i):
	if direct=="up":
		if menupos==0:
			menupos=btnno.size()-1
		else:
			menupos=menupos-1
		i=menupos
	elif direct=="down":
		if menupos==btnno.size()-1:
			menupos=0
		else:
			menupos=menupos+1
		i=menupos
	else:
		menupos=i
		
	var item=global.gamedetails(btngame[i])
	if !get_node("split/right/desc").get_text()==item[2].replacen("&#x2c;",","):
		print("button: " +str(i) + " game: "+ str(btngame[i]) +" "+ item[0])
		colorbtn(i)
		get_node("split/right/pack").set_text(item[1])
		get_node("split/right/desc").set_text(item[2].replacen("&#x2c;",","))
		print("res://media/Pictures/"+str(item[9])+".png")
		get_node("split/right/icon").set_texture(load("res://media/Pictures/"+str(item[9])+".png"))
		get_node("split/right/players").set_text("From "+item[10]+" to "+item[11]+" Players")
		get_node("split/ScrollContainer").ensure_control_visible(btnno[i])
	
func colorbtn(j):
	var item
	item = global.gamedetails(btngame[j])
	
	get_node("PackHeadder/CurrentPack").add_color_override("font_color", Color(item[6]))
	
	for i in btnno.size():
		btnno[i].add_color_override("font_color", Color(item[4]))
		item = global.gamedetails(btngame[j])
		
	btnno[j].add_color_override("font_color", Color(item[6]))
	btnno[j].add_color_override("font_color_hover", Color(item[6]))
	
	get_node("background").set_frame_color(Color(item[3]))
	
	get_node("split/right/pack").add_color_override("font_color", Color(item[7]))
	
	get_node("split/right/desc").add_color_override("font_color", Color(item[5]))
	
	get_node("split/right/players").add_color_override("font_color", Color(item[7]))


func _on_sett_pressed():
	global.splay(global.ssett)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://sett.tscn")



func _on_rand_pressed():
	cyclemenu(null,randi()%(btnno.size()+1))
	
func _on_PackLeft():
	if global.currentpack==0:
		global.currentpack=global.packlist.size()-1
	else:
		global.currentpack=global.currentpack-1
		
	get_node("PackHeadder/CurrentPack").set_text(global.packlist[global.currentpack])
	deletemenu()
	createmenu()
	cyclemenu(null,0)
		
func _on_PackRight():
	if global.currentpack==global.packlist.size()-1:
		global.currentpack=0
	else:
		global.currentpack=global.currentpack+1
		
	get_node("PackHeadder/CurrentPack").set_text(global.packlist[global.currentpack])
	deletemenu()
	createmenu()
	cyclemenu(null,0)

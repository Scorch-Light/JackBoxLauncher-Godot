extends Node
var btnno=[]

func _ready():
	global.splay(global.sback)
	createmenu()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		global.splay(global.sback)
		get_tree().quit() # default behavior

func createmenu():
	btnno.resize(0)
	for i in global.gamestot:
		var item=global.gamelist[i].split(",")
		print(item[0])
		btnno.append(Button.new())
		get_node("ScrollContainer/mainmenu").add_child(btnno[i])
		btnno[i].set_text(item[0])
		btnno[i].set_flat(true)
		btnno[i].connect("pressed", self, "_menu"+str(i)+"_pressed")
		btnno[i].connect("hover", self, "_menu"+str(i)+"_hover")

func _process(delta):		
	for i in global.gamestot:
		if btnno[i].is_hovered():
			var item=global.gamelist[i].split(",")
			get_node("right/name").set_text(item[0])
			get_node("right/pack").set_text(item[1])
			get_node("right/desc").set_text(item[2].replacen("&#x2c;",","))
			#print("res://media/Pictures/"+str(item[9])+".png")
			get_node("right/icon").set_texture(load("res://media/Pictures/"+str(item[9])+".png"))
			get_node("right/players").set_text("From "+item[10]+" to "+item[11]+" Players")

		if btnno[i].is_pressed():
			#print(i)
			var item=global.gamelist[i].split(",")
			OS.execute("steam", ["-applaunch",item[12]], true) 




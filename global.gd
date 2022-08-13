extends Node

#Views
const main=0

#sounds
var sback = preload("res://media/sound/back.ogg")
var scard = preload("res://media/sound/card.ogg")
var schaos = preload("res://media/sound/chaos.ogg")
var scoin = preload("res://media/sound/coin.ogg")
var sdice = preload("res://media/sound/dice.ogg")
var slife = preload("res://media/sound/life.ogg")
var ssett = preload("res://media/sound/sett.ogg")
var stoggle = preload("res://media/sound/toggle.ogg")
var swalk = preload("res://media/sound/walk.ogg")

#gamelist
var gamestot=0
var gamelist=PoolStringArray()

var packtot=0
var packlist=PoolStringArray()


var gamelistseperate=false
var currentpack=0


var audio = null



func _ready():
	load_settings()
	load_games()
	load_packs()
	print(OS.get_user_data_dir())
	#pass
# warning-ignore:unused_argument
func splay(sound):
	#audio = node
	sound.loop = false
	#audio.set_stream(sound)
	#audio.play()
	

func save_settings():
	var file = File.new()
	file.open("user://config.dat", File.WRITE)
	
	#settings
	file.store_line(var2str(OS.window_fullscreen))
	file.store_line(var2str(global.gamelistseperate))
	
	#close
	file.close()
	
func load_settings():
	var file = File.new()
	file.open("user://config.dat", File.READ)
	if file.file_exists("user://config.dat"):
		#settings
		OS.window_fullscreen= str2var(file.get_line())
		global.gamelistseperate=str2var(file.get_line())
		
	#close
	file.close()

func load_games():
	var file = File.new()
	file.open("res://media/games.csv",file.READ)
	
	gamelist.resize(0)
	while !file.eof_reached():
		gamelist.append(file.get_line ())
		
	file.close()
	gamelist.remove(0)
	gamelist.remove(gamelist.size()-1)
	gamestot=gamelist.size()

func load_packs():
	packlist.resize(0)
	for i in global.gamestot:
		if gamedetails(i)[1] in packlist:
			print("Already in Packlist: " + str(gamedetails(4)[1]))
		else:
			packlist.append(gamedetails(i)[1])
			print("Added to Pack List: " + str(gamedetails(i)[1]))
	
	currentpack = 0
	
func gamedetails(i):
	var item
	item=global.gamelist[i].split(",")
	return item


extends Node

var loader
var wait_frames
var time_max = 100
var current_scene
var path_going_to = ""

onready var move_hud = $move_hud
onready var bg_hud = $bg_hud
onready var tex_progress = $bg_hud/TextureProgress
onready var move_label = $move_hud/Label
onready var progress_label = $bg_hud/Label
onready var root = get_tree().get_root()

func _ready():
	move_hud.visible = false
	bg_hud.visible = false
	set_process(false)
	current_scene = root.get_child(root.get_child_count() - 1)
	
func set_move_hud(value_path, value_name):
	path_going_to = value_path
	move_label.text = value_name
	move_hud.visible = true
	
func unset_move_hud():
	move_hud.visible = false

func _on_ReviveButton_button_up():
	GTimerSpawner.enemies.clear()
	goto_scene(path_going_to)

func goto_scene(path):
	loader = ResourceLoader.load_interactive(path)
	if(loader == null):
		print("error load from Reasource Loader :p")
		return
	set_process(true)
	
	current_scene.queue_free()
	
	#start your "loading..." animation
	#get_node here!!
	tex_progress.value = 0
	progress_label.set_text("0%")
	bg_hud.visible = true
	
	wait_frames = 100
	
func _process(_delta):
	if(loader == null):
		set_process(false)
		return
		
	if(wait_frames > 0):
		wait_frames -= 1
		return
		
	var t = OS.get_ticks_msec()
	while(OS.get_ticks_msec() < t + time_max):
		
		var err = loader.poll()
		
		if(err == ERR_FILE_EOF): #load finished
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			bg_hud.visible = false
			break
		elif(err == OK):
			update_progress()
		else:
			print("error while loading resource!! ;p")
			loader = null
			break
			
func update_progress():
	var _progress = float(loader.get_stage()) / loader.get_stage_count()
	var _tmpInt = int(_progress * 100)
	tex_progress.value = _tmpInt
	progress_label.set_text(String(_tmpInt) + "%")
		
		
func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	root.add_child(current_scene)

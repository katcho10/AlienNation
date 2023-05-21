extends Spatial

onready var creaditors = $CanvasLayer/AnimatedSprite
onready var timer = $Timer

export var num_max_img = 12
var curr_frame = 0

func _ready():
	pass


func _on_next_btn_button_up():
	timer.stop()
	timer.start()
	set_next_frame()

func set_next_frame():
	curr_frame += 1
	if(curr_frame >= num_max_img):
		curr_frame = 0
	creaditors.frame = curr_frame

func _on_menu_btn_button_up():
	GBgLoader.goto_scene("res://Scenes/Worlds/Main_menu.tscn")


func _on_Timer_timeout():
	set_next_frame()

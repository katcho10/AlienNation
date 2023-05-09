extends Node

onready var timer = $Timer
onready var monster_info_bg = $Monster_Info_BG
onready var label_name = $Monster_Info_BG/name_label
onready var label_max_hp = $Monster_Info_BG/max_hp_label
onready var mhp_progress = $Monster_Info_BG/TextureProgress
	

func display_info(monster):
	label_name.text = monster.mname
	label_max_hp.text = String(monster.max_life)
	mhp_progress.max_value = monster.max_life
	mhp_progress.value = monster.life
	monster_info_bg.visible = true
	timer.stop()
	timer.start()

func _on_Timer_timeout():
	monster_info_bg.visible = false
	
#func _notification(what):
#	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		#set progress bar for save
		#save all
#		call_deferred("just_quit_me")

#func just_quit_me():
#	get_tree().quit()

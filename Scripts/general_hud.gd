extends Node

enum STAGES {
	ZERO = 0,
	ONE = 1,
	TWO = 2,
	THREE = 3,
	FOUR = 4
}

onready var timer = $Timer
onready var monster_info_bg = $Monster_Info_BG
onready var label_name = $Monster_Info_BG/name_label
onready var label_max_hp = $Monster_Info_BG/max_hp_label
onready var mhp_progress = $Monster_Info_BG/TextureProgress
	
onready var save_progress = $Saving_BG/TextureProgress
onready var save_tween = $Tween
var phaze = STAGES.ZERO
var has_on_cell_quit:bool = false

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
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		has_on_cell_quit = true
		save_proc()

#func just_quit_me():
#	get_tree().quit()

func save_proc():
	match phaze:
		STAGES.ZERO:
			$Saving_BG/Label.text = "saving..."
			GPlayerStatus.on_save()
			save_progress.value = 0
			$Saving_BG/res_btn.visible = false
			$Saving_BG/quit_btn.visible = false
			$Saving_BG.visible = true
			print("phaze zero")
			save_tween.interpolate_property(save_progress, "value", 0, 35, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
			save_tween.start()
			phaze = STAGES.ONE
			pass
			
		STAGES.ONE:
			GPlayerStatus.skill_manager.on_save()
			print("phaze one")
			save_tween.interpolate_property(save_progress, "value", 35, 65, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
			save_tween.start()
			phaze = STAGES.TWO
			pass
			
		STAGES.TWO:
			GPlayerStatus.equipments.on_save()
			print("phaze two")
			save_tween.interpolate_property(save_progress, "value", 65, 88, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
			save_tween.start()
			phaze = STAGES.THREE
			pass
			
		STAGES.THREE:
			GPlayerInventory.on_save()
			print("phaze three")
			save_tween.interpolate_property(save_progress, "value", 88, 100, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
			save_tween.start()
			phaze = STAGES.FOUR
			pass
			
		STAGES.FOUR:
			print("phaze four")
			if not has_on_cell_quit:
				$Saving_BG/Label.text = "save complete!"
				$Saving_BG/res_btn.visible = true
				$Saving_BG/quit_btn.visible = true
				phaze = STAGES.ZERO
			else:
				get_tree().quit()
			
		_:
			pass
	pass

func _on_save_and_exit_tbtn_released():
	save_proc()

func _on_Tween_tween_all_completed():
	save_proc()
	pass # Replace with function body.

func _on_res_btn_button_up():
	GPlayerInventory.clear_debug_label()
	$Saving_BG.visible = false
	pass # Replace with function body.

func _on_quit_btn_button_up():
	get_tree().quit()
	pass # Replace with function body.

func hud_clear(value = true):
	$save_and_exit_tbtn.visible = !value

extends Spatial

onready var conti_btn = $CanvasLayer/continue_btn

func _ready():
	if has_save():
		GPlayerInventory.on_load()
		$CanvasLayer/new_game_btn.visible = false
		$Timer.start(1)
	pass

func has_save():
	var savegame = File.new()
	if !savegame.file_exists("user://status.txt"):
		$CanvasLayer/continue_btn.visible = false
		return false
	else:
		$CanvasLayer/new_game_btn.visible = true
		return true

func _on_new_game_btn_button_up():
	GPlayerStatus.spawn_position = Vector3(18.784, 0.0, -4.676)
	GPlayerStatus.update_status_display()
	GPlayerInventory.new_game_items()
	GPlayerInventory.hud_clear(false)
	GGeneral_Hud.hud_clear(false)
	GPlayerStatus.status_set_visible()
	GBgLoader.goto_scene("res://Scenes/Worlds/Junction.tscn")

func _on_quit_btn_button_up():
	get_tree().quit()

func _on_continue_btn_button_up():
	GPlayerStatus.spawn_position = Vector3(18.784, 0.0, -4.676)
	GPlayerInventory.hud_clear(false)
	GGeneral_Hud.hud_clear(false)
	GPlayerStatus.status_set_visible()
	GBgLoader.goto_scene("res://Scenes/Worlds/Junction.tscn")

func _on_credits_btn_button_up():
	GBgLoader.goto_scene("res://Scenes/Worlds/Creadits.tscn")

func _on_Timer_timeout():
	conti_btn.visible = true
	pass

extends Node

var max_life:float = 80.0
var life:float = 80.0

var max_energy:float = 20.0
var energy:float = 20.0

var max_exp:int = 100
var remaining_exp:int = 100
var level:int = 1

var attack_damage:int = 10
var power_damage:int = 10
var armor:float = 0.0

var equip_total_attack:int = 0
var equip_total_magic:int = 0
var equip_total_armor:float = 0.0

var status_point:int = 0

var money:int = 3000

var is_knockout:bool = false
var ko_tcount = 24

var spawn_position:Vector3 = Vector3(0.0, 0.05, 0.0)
var player = null

onready var hp_bar = $status_bg/HpProgress
onready var hp_label = $status_bg/HpLabel
onready var en_bar = $status_bg/EnProgress
onready var en_label = $status_bg/EnLabel
onready var ex_bar = $status_bg/ExpProgress
onready var ex_label = $status_bg/ExpLabel
onready var lvl_label = $status_bg/LvlLabel
onready var money_label = $status_bg/GoldLabel

onready var joystick = $Control/Joystick/TouchScreenButton
onready var skill_manager = $skill_bg

onready var control_hud = $Control

onready var equipments = $equipment_bg

func initialized_player(value):
	player = load("res://Scenes/Character/Cho.tscn").instance()
	player.translation = spawn_position
	value.add_child(player)
	#no need for this if i got lobby or menu scene
	#update_status_display()
	
#not use ???
func update_status_display():
	hp_bar.max_value = max_life
	hp_bar.value = life
	hp_label.text = String(round(life))
	en_bar.max_value = max_energy
	en_bar.value = energy
	en_label.text = String(round(energy))
	ex_bar.max_value = max_exp
	ex_bar.value = max_exp - remaining_exp
	ex_label.text = String(remaining_exp)
	lvl_label.text = String(level)
	money_label.text = String(money)
	
func overall_damage():
	return attack_damage + equipments.equipment_attack

func overall_power_damage():
	return power_damage + equipments.equipment_power

func overall_defence():
	return armor + equipments.equipment_armor

func hit_player(value):
	if(is_knockout):
		return
	
	var computed_dmg = value - overall_defence()
	if computed_dmg <= 0:
		player.miss_effect()
		return
	
	life -= computed_dmg
	player.hit_effect(computed_dmg)
	hp_bar.value = life
	hp_label.text = String(life)
	
	if(life < 1):
		decrease_money(48 * level)
		is_knockout = true
		player.on_knockout()
		ko_tcount = 24
		$knockout_bg/ko_counter.text = "respawn: " + String(ko_tcount)
		$knockout_bg.visible = true
		GPlayerInventory.hud_clear()
		movement_control_hide()
	
func add_expirence(value):
	remaining_exp -= value
	if(remaining_exp < 1):
		level_up()
		
	ex_bar.max_value = max_exp
	ex_bar.value = max_exp - remaining_exp
	ex_label.text = String(remaining_exp)
	
func level_up():
	player.level_up_effect()
	var add_every_ten_lvl = 0
	var mod_lvl = (level + 1) % 10
	if(mod_lvl == 0):
		add_every_ten_lvl = 1000
		
	var new_max_exp = max_exp + (level * 45)
	max_exp = add_every_ten_lvl + new_max_exp
	remaining_exp = max_exp
	level = level + 1
	status_point += 3
	lvl_label.text = String(level)
	
	#additional every level
	max_life += 2
	max_energy += 1
	hp_bar.max_value = max_life
	en_bar.max_value = max_energy
	
	
	
#func update_spirit():
#	spirit += 0.2
#	spirit = min(max_spirit, spirit)
#	sp_bar.value = spirit
#	sp_label.text = String(round(spirit))
#
#func update_magic():
#	mana += 0.2
#	mana = min(max_mana, mana)
#	mp_bar.value = mana
#	mp_label.text = String(round(mana))
func can_decressed_energy(value):
	if energy >= value:
		return true
	return false

func decresse_energy(value):
	energy -= value
	en_bar.value = energy
	en_label.text = String(round(energy))

func can_normal_attack():
	if(energy > 0.9):
		return true
	return false

func _on_Timer_timeout():
	pass
	
	if(is_knockout):
		ko_tcount -= 1
		$knockout_bg/ko_counter.text = "respawn: " + String(ko_tcount)
		if(ko_tcount < 0):
			to_resurect()
	
func restor_status(value:Vector3):
	life += value.x
	energy += value.y
	
	life = min(max_life, life)
	hp_bar.value = life
	hp_label.text = String(round(life))
	
	energy = min(max_energy, energy)
	en_bar.value = energy
	en_label.text = String(round(energy))

func add_money(value):
	money += value
	money_label.text = String(money)

func decrease_money(value):
	money -= value
	money_label.text = String(money)

func to_resurect():
	is_knockout = false
	GBgLoader.path_going_to = "res://Scenes/Worlds/Junction.tscn"
	life = max_life
	energy = max_energy
	update_status_display()
	spawn_position = Vector3(17.589, 0.0, -4.867)
	GBgLoader._on_ReviveButton_button_up()
	movement_control_hide(false)
	GPlayerInventory.hud_clear(false)
	$knockout_bg.visible = false

func _on_Button_button_up():
	to_resurect()

func status_set_visible():
	$status_bg.visible = true
	$status_button.visible = true
	$equip_button.visible = true
	control_hud.visible = true
	skill_manager.visible = true

func game_pause(value = true):
	$status_button.visible = !value
	$equip_button.visible = !value
	control_hud.visible = !value
	skill_manager.visible = !value
	get_tree().paused = value
	
func movement_control_hide(value = true):
	$status_button.visible = !value
	$equip_button.visible = !value
	control_hud.visible = !value
	skill_manager.visible = !value

func _on_status_button_released():
	movement_control_hide()
	GPlayerInventory.hud_clear()
	$add_status_bg.initialize()
	
func _on_equip_button_released():
	movement_control_hide()
	GPlayerInventory.hud_clear()
	equipments.initialize()

func dictionary_convert(dvalue):
	max_life 		= dvalue.get("max_life")
	life 			= dvalue.get("life")
	max_energy		= dvalue.get("max_energy")
	energy			= dvalue.get("energy")
	max_exp			= int(dvalue.get("max_exp"))
	remaining_exp 	= int(dvalue.get("remaining_exp"))
	level			= int(dvalue.get("level"))
	attack_damage	= int(dvalue.get("attack_damage"))
	power_damage	= int(dvalue.get("power_damage"))
	armor			= dvalue.get("armor")
	status_point	= int(dvalue.get("status_point"))
	money			= int(dvalue.get("money"))
	
	update_status_display()
	
func on_save():
	var tmpD = {
		"max_life" : max_life,
		"life" : life,
		"max_energy" : max_energy,
		"energy" : energy,
		"max_exp" : max_exp,
		"remaining_exp" : remaining_exp,
		"level" : level,
		"attack_damage" : attack_damage,
		"power_damage" : power_damage,
		"armor" : armor,
		"status_point" : status_point,
		"money" : money
	}

	var savegame = File.new()
	savegame.open("user://status.txt", File.WRITE)
	savegame.store_line(to_json(tmpD))
	savegame.close()
	print("save status")
	
	#equipments.on_save()
	#skill_manager.on_save()

func on_load():
	var savegame = File.new()
	if !savegame.file_exists("user://status.txt"):
		print("status files don`t exist!!")
		return
	
	savegame.open("user://status.txt", File.READ)
	var currline = parse_json(savegame.get_line())
	dictionary_convert(currline)
	savegame.close()
	print("load status")
	
	equipments.on_load()
	skill_manager.on_load()

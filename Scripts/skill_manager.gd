extends Node

enum SKILL_type {
	NONE = 0,
	PROJECTILE = 1,
	AOE = 2,
	EXPLOSION = 3
}


#var ID:int = 0
#var type:int = SKILL_type.NONE
#var cd_max:int = 0
#var damage:int = 0
#var require_energy:int = 0
#var effect:String = "None"
#var sname:String = "None" --> not nessarry
#var description:String = "None" --> not nessarry

var skills = [
	[0, SKILL_type.NONE, 0, 0, 0, "None"],
	[0, SKILL_type.NONE, 0, 0, 0, "None"],
	[0, SKILL_type.NONE, 0, 0, 0, "None"]
]

var effect00 = null
var effect01 = null
var effect02 = null

var sk_currtime_00:int = 0
var sk_currtime_01:int = 0
var sk_currtime_02:int = 0

onready var label_cd_00 = $touch01/cooldown
onready var label_cd_01 = $touch02/cooldown
onready var label_cd_02 = $touch03/cooldown
onready var icon_00 = $touch01/all_skill_icons
onready var icon_01 = $touch02/all_skill_icons
onready var icon_02 = $touch03/all_skill_icons

var current_skill = -1

func _ready():
	#skill one tmp
	skills[0][0] = 1
	skills[0][1] = SKILL_type.PROJECTILE
	skills[0][2] = 20
	skills[0][3] = 90
	skills[0][4] = 5
	skills[0][5] = "res://Scenes/Effects/Energy_Ball.tscn"
	icon_00.frame = skills[0][0]
	effect00 = load(skills[0][5])


func init_slot(index):
	match index:
		0:
			if skills[0][1] != SKILL_type.NONE:
				effect00 = load(skills[0][5])
				
			icon_00.frame = skills[0][0]
			sk_currtime_00 = 0
		1:
			if skills[1][1] != SKILL_type.NONE:
				effect01 = load(skills[1][5])
				
			icon_01.frame = skills[1][0]
			sk_currtime_01 = 0
		2:
			if skills[2][1] != SKILL_type.NONE:
				effect02 = load(skills[2][5])
				
			icon_02.frame = skills[2][0]
			sk_currtime_02 = 0
		_:
			pass
	
func get_curr_sk_damage():
	return skills[current_skill][3]

func get_curr_sk_type():
	return skills[current_skill][1]

func get_curr_sk_instance():
	match current_skill:
		0:
			return effect00.instance()
		1:
			return effect01.instance()
		2:
			return effect02.instance()
		_:
			return null


func _on_touch01_released():
	current_skill = 0
	if can_use_sksl0():
		GPlayerStatus.player.do_animation(skills[current_skill][0])
	pass # Replace with function body.

func _on_touch02_released():
	current_skill = 1
	if can_use_sksl1():
		GPlayerStatus.player.do_animation(skills[current_skill][0])
	pass # Replace with function body.

func _on_touch03_released():
	current_skill = 2
	if can_use_sksl2():
		GPlayerStatus.player.do_animation(skills[current_skill][0])
	pass # Replace with function body.
	
func can_use_sksl0():
	if skills[0][1] == SKILL_type.NONE:
		return false
	
	if GPlayerStatus.can_decressed_energy(skills[0][4]) and sk_currtime_00 <= 0:
		GPlayerStatus.decresse_energy(skills[0][4])
		sk_currtime_00 = skills[0][2]
		label_cd_00.text = String(sk_currtime_00)
		label_cd_00.visible = true
		return true
	return false

func can_use_sksl1():
	if skills[1][1] == SKILL_type.NONE:
		return false
	
	if GPlayerStatus.can_decressed_energy(skills[1][4]) and sk_currtime_01 <= 0:
		GPlayerStatus.decresse_energy(skills[1][4])
		sk_currtime_01 = skills[1][2]
		label_cd_01.text = String(sk_currtime_01)
		label_cd_01.visible = true
		return true
	return false
	
func can_use_sksl2():
	if skills[2][1] == SKILL_type.NONE:
		return false
	
	if GPlayerStatus.can_decressed_energy(skills[2][4]) and sk_currtime_02 <= 0:
		GPlayerStatus.decresse_energy(skills[2][4])
		sk_currtime_02 = skills[2][2]
		label_cd_02.text = String(sk_currtime_02)
		label_cd_02.visible = true
		return true
	return false

func update_slot00():
	sk_currtime_00 -= 1
	if sk_currtime_00 <= 0:
		label_cd_00.visible = false
		return
	
	label_cd_00.text = String(sk_currtime_00)
	
func update_slot01():
	sk_currtime_01 -= 1
	if sk_currtime_01 <= 0:
		label_cd_01.visible = false
		return
	
	label_cd_01.text = String(sk_currtime_01)
	
func update_slot02():
	sk_currtime_02 -= 1
	if sk_currtime_02 <= 0:
		label_cd_02.visible = false
		return
	
	label_cd_02.text = String(sk_currtime_02)
	

func _on_Timer_timeout():
	update_slot00()
	update_slot01()
	update_slot02()

func clear_slot(index):
	skills[index][0] = 0
	skills[index][1] = SKILL_type.NONE
	skills[index][2] = 0
	skills[index][3] = 0
	skills[index][4] = 0
	skills[index][5] = "None"
	
	match index:
		0:
			icon_00.frame = 0
			effect00 = null
			sk_currtime_00 = 0
		1:
			icon_01.frame = 0
			effect01 = null
			sk_currtime_01 = 0
		2:
			icon_02.frame = 0
			effect02 = null
			sk_currtime_02 = 0
		_:
			pass

# return value (-1 = no vacant) (0 = OK) (1 = already exist)
func add_skill(abuff):
	var vacant_slot = -1
	for i in [2, 1, 0]:
		if abuff[0] == skills[i][0]:
			return 1
		if skills[i][1] == SKILL_type.NONE:
			vacant_slot = i
	
	if vacant_slot <= -1:
		return -1
		
	skills[vacant_slot][0] = abuff[0]
	skills[vacant_slot][1] = abuff[1]
	skills[vacant_slot][2] = abuff[2]
	skills[vacant_slot][3] = abuff[3]
	skills[vacant_slot][4] = abuff[4]
	skills[vacant_slot][5] = abuff[5]
	init_slot(vacant_slot)
	return 0

#var ID:int = 0
#var type:int = SKILL_type.NONE
#var cd_max:int = 0
#var damage:int = 0
#var require_energy:int = 0
#var effect:String = "None"
#var sname:String = "None" --> not nessarry
#var description:String = "None" --> not nessarry
func convert_to_dict(rvalue):
	var tmp = {
		"ID" : rvalue[0],
		"type" : rvalue[1],
		"cd_max" : rvalue[2],
		"damage" : rvalue[3],
		"req_energy" : rvalue[4],
		"effect" : rvalue[5]
	}
	return tmp

func set_addon_asdict_buff(indx, dvalue):
	skills[indx][0] = int(dvalue.get("ID"))
	skills[indx][1] = int(dvalue.get("type"))
	skills[indx][2] = int(dvalue.get("cd_max"))
	skills[indx][3] = int(dvalue.get("damage"))
	skills[indx][4] = int(dvalue.get("req_energy"))
	skills[indx][5] = dvalue.get("effect")
	init_slot(indx)
	

func on_save():
	var savegame = File.new()
	savegame.open("user://skill.txt", File.WRITE)
	
	#skill buff
	for s in skills:
		var nodedata = convert_to_dict(s)
		savegame.store_line(to_json(nodedata))

	savegame.close()
	print("skill saved")
	
func on_load():
	var savegame = File.new()
	if !savegame.file_exists("user://skill.txt"):
		print("skill save don`t exist!!!")
		return
		
	savegame.open("user://skill.txt", File.READ)
	
	#skill
	var index = 0
	while(savegame.get_position() < savegame.get_len()):
		var currentline = parse_json(savegame.get_line())
		if typeof(currentline) == TYPE_DICTIONARY:
			set_addon_asdict_buff(index, currentline)
			index += 1
		else:
			print("error loading skill")
	
	savegame.close()
	print("skill loaded")

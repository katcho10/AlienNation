extends TextureRect

var additional_hp:float = 0.0
var additional_en:float = 0.0
var additional_attack:int = 0
var additional_pattack:int = 0
var additional_defence:float = 0.0

var tmp_status_points:int = 0

onready var label_max_hp = $max_hp_label
onready var label_max_en = $max_en_label
onready var label_attack = $attack_label
onready var label_pattack = $pattack_label
onready var label_defence = $defence_label
onready var label_stat_points = $remain_stat_label

onready var str_button = $add_str_button
onready var int_button = $add_int_button
onready var dex_button = $add_dex_button

func _ready():
	pass
	
func has_status_point():
	if tmp_status_points <= 0:
		str_button.disabled = true
		int_button.disabled = true
		dex_button.disabled = true
		return false
	else:
		str_button.disabled = false
		int_button.disabled = false
		dex_button.disabled = false
		return true

func initialize():
	tmp_status_points = GPlayerStatus.status_point
	has_status_point()
	label_stat_points.text = String(tmp_status_points)
	label_max_hp.text = String(GPlayerStatus.max_life)
	label_max_en.text = String(GPlayerStatus.max_energy)
	label_attack.text = String(GPlayerStatus.attack_damage)
	label_pattack.text = String(GPlayerStatus.power_damage)
	label_defence.text = String(GPlayerStatus.armor)
	
	visible = true


func _on_add_str_button_button_up():
	tmp_status_points -= 1
	additional_attack += 2
	additional_hp += 10
	
	label_attack.text = String(GPlayerStatus.attack_damage + additional_attack)
	label_max_hp.text = String(GPlayerStatus.max_life + additional_hp)
	label_stat_points.text = String(tmp_status_points)
	has_status_point()

func _on_add_int_button_button_up():
	tmp_status_points -= 1
	additional_pattack += 2
	additional_en += 10
	
	label_max_en.text = String(GPlayerStatus.max_energy + additional_en)
	label_pattack.text = String(GPlayerStatus.power_damage + additional_pattack)
	label_stat_points.text = String(tmp_status_points)
	has_status_point()

func _on_add_dex_button_button_up():
	tmp_status_points -= 1
	additional_defence += 1.0
	additional_attack += 2
	
	label_defence.text = String(GPlayerStatus.armor + additional_defence)
	label_attack.text = String(GPlayerStatus.attack_damage + additional_attack)
	label_stat_points.text = String(tmp_status_points)
	has_status_point()

func clear_additional():
	additional_hp = 0.0
	additional_en = 0.0
	additional_attack = 0
	additional_pattack = 0
	additional_defence = 0.0
	tmp_status_points = 0

func _on_close_button_button_up():
	clear_additional()
	GPlayerStatus.movement_control_hide(false)
	GPlayerInventory.hud_clear(false)
	visible = false

func _on_reset_button_button_up():
	clear_additional()
	initialize()
	

func _on_apply_button_button_up():
	GPlayerStatus.max_life += additional_hp
	GPlayerStatus.max_energy += additional_en
	GPlayerStatus.attack_damage += additional_attack
	GPlayerStatus.power_damage += additional_pattack
	GPlayerStatus.armor += additional_defence
	GPlayerStatus.status_point = tmp_status_points
	GPlayerStatus.update_status_display()
	clear_additional()
	initialize()

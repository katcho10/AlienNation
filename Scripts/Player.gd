extends KinematicBody

var MAX_SPEED = 6
var speed = 0
var ACCELERATION = 10
var dir = Vector3.ZERO

onready var model = $cho_armature
onready var anim_tree = $AnimationTree
onready var cam_holder = $Camera_Holder
var camera_basis = null

onready var hitbox = $cho_armature/Hitbox

var label_def_pos = Vector3.ZERO
onready var dmg_label_3D = $Label3D
onready var tween_dmg = $Tween

onready var gun_point = $cho_armature/gun_point
onready var front_point = $cho_armature/front_point

var levelup = preload("res://Scenes/Effects/Level_Up_Effey.tscn")
#var bullet = preload("res://Scenes/Effects/Bullet.tscn")
var bullet = preload("res://Scenes/Effects/Lighting_Ball.tscn")
var explode = preload("res://Scenes/Effects/Explosion.tscn")
var lastdir = Vector3.BACK

func _ready():
	camera_basis = $Camera_Holder/Camera.get_global_transform().basis
	
	label_def_pos = dmg_label_3D.transform.origin
	tween_dmg.interpolate_property(dmg_label_3D, "translation", label_def_pos, label_def_pos + Vector3(0, 1, 0), 0.65,Tween.TRANS_LINEAR,Tween.EASE_OUT)
#	tween_dmg.interpolate_property(label_dmg, "scale", Vector3(1, 1, 1), Vector3(2, 2, 2), 0.35,Tween.TRANS_LINEAR,Tween.EASE_OUT)

func _input(event):
	if event is InputEventScreenDrag:
		if event.index == GPlayerStatus.joystick.ongoing_drag:
			return
		var holder_rot = cam_holder.get_rotation()
		holder_rot.y -= deg2rad(event.relative.x)
		cam_holder.set_rotation(holder_rot)
		camera_basis = $Camera_Holder/Camera.get_global_transform().basis
		
	
func _process(delta):
#	dir.z = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
#	dir.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
#	dir.z = tmp_z
#	dir.x = tmp_x

	dir = camera_basis * GPlayerStatus.joystick.get_direction()
	dir.y = 0
	
	if(dir == Vector3.ZERO):
		speed = 0
		anim_tree.set("parameters/idle_to_move/blend_position", 0)
		
		if(Input.is_action_just_pressed("ui_accept") and GPlayerStatus.can_normal_attack()):
			anim_tree.set("parameters/slash_left/active", true)
		
		if(Input.is_action_just_pressed("ui_accept_two") and GPlayerStatus.can_fire_shot()):
			anim_tree.set("parameters/shoot/active", true)
			
	else:
		speed += ACCELERATION * delta
		speed = min(MAX_SPEED, speed)
		var motion = dir.normalized() * speed
		motion = move_and_slide(motion)
		lastdir = dir
		var tmp_angle = model.get_rotation()
		tmp_angle.y = atan2(dir.x, dir.z)
		model.set_rotation(tmp_angle)
		anim_tree.set("parameters/idle_to_move/blend_position", dir.length())
	
	
			

func on_knockout():
	set_process(false)
	anim_tree.set("parameters/move_to_ko/blend_amount", 1.0)
	$shadow.visible = false

func on_hit_enemy():
	var somebodies = hitbox.get_overlapping_bodies()
	if(somebodies):
		somebodies[0].take_hit(GPlayerStatus.overall_damage())
	GPlayerStatus.decresse_energy(1.0)

func hit_effect(value_dmg):
	dmg_label_3D.text = String(-value_dmg)
	dmg_label_3D.visible = true
	tween_dmg.start()

func miss_effect():
	dmg_label_3D.text = "Miss!"
	dmg_label_3D.visible = true
	dmg_label_3D.modulate = Color.aqua
	tween_dmg.start()
	
func level_up_effect():
	add_child(levelup.instance())

func on_shoot():
	var my_tmp = bullet.instance()
	my_tmp.global_transform = hitbox.global_transform
	my_tmp.dir = lastdir
	get_parent().add_child(my_tmp)
	
	var tmp2 = explode.instance()
	tmp2.global_transform = global_transform
	get_parent().add_child(tmp2)

func _on_Tween_tween_all_completed():
	dmg_label_3D.modulate = Color.red
	dmg_label_3D.visible = false
	dmg_label_3D.transform.origin = label_def_pos
	var tmp_xz = rand_range(-1, 1)
	tween_dmg.interpolate_property(dmg_label_3D, "translation", label_def_pos, label_def_pos + Vector3(tmp_xz, 1, tmp_xz), 0.65,Tween.TRANS_LINEAR,Tween.EASE_OUT)
#	tween_dmg.interpolate_property(label_dmg, "scale", Vector3(1, 1, 1), Vector3(2, 2, 2), 0.35,Tween.TRANS_LINEAR,Tween.EASE_OUT)

#func turn_cam_right():
#	var holder_rot = $Camera_Holder.get_rotation()
#	holder_rot.y += deg2rad(45)
#	$Camera_Holder.set_rotation(holder_rot)
#	camera_basis = $Camera_Holder/Camera.get_global_transform().basis
#
#func turn_cam_left():
#	var holder_rot = $Camera_Holder.get_rotation()
#	holder_rot.y -= deg2rad(45)
#	$Camera_Holder.set_rotation(holder_rot)
#	camera_basis = $Camera_Holder/Camera.get_global_transform().basis

#here you need the skill ID
func do_animation(id_value):
	match id_value:
		1:
			anim_tree.set("parameters/shoot/active", true)
		2:
			anim_tree.set("parameters/slash_right/active", true)
		3:
			anim_tree.set("parameters/shoot/active", true)
		4:
			anim_tree.set("parameters/slash_right/active", true)
		_:
			pass

func on_skill():
	var curr_idx = GPlayerStatus.skill_manager.get_curr_sk_type()
	var my_tmp = GPlayerStatus.skill_manager.get_curr_sk_instance()
	var dmg = GPlayerStatus.skill_manager.get_curr_sk_damage()
	var odmg = GPlayerStatus.overall_power_damage()
	
	match curr_idx:
		GPlayerStatus.skill_manager.SKILL_type.NONE:
			print("here none")
			return
		GPlayerStatus.skill_manager.SKILL_type.PROJECTILE:
			my_tmp.translation = gun_point.global_translation
			my_tmp.damage = dmg + odmg
			my_tmp.dir = lastdir
			get_parent().add_child(my_tmp)
			return
			
		GPlayerStatus.skill_manager.SKILL_type.AOE:
			my_tmp.translation = global_translation
			my_tmp.damage = dmg + odmg
			get_parent().add_child(my_tmp)
			pass
			
		GPlayerStatus.skill_manager.SKILL_type.EXPLOSION:
			my_tmp.translation = front_point.global_translation
			my_tmp.damage = dmg + (odmg * 2)
			get_parent().add_child(my_tmp)
			pass
		_:
			pass
	pass

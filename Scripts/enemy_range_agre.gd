extends KinematicBody

enum { FIGHTING ,PATROL ,KNOCKOUT }

export var max_speed = 3.5
export var min_speed = 1.5
var speed = 1.5
const ANIM_ATTACK:String = "attack"
const ANIM_IDLE:String = "hover"
const ANIM_WALK:String = "fly"
const ANIM_RUN:String = "fly"
const ANIM_KNOCKOUT:String = "knockout"

var dir = Vector3.BACK
var velocity = Vector3.ZERO

onready var phasez_timer = $Timer

onready var anim_player = $AnimationPlayer
var animation = "hover"
var target_point = Vector3.ZERO
var phase_duration:int = 1

var state = PATROL
export var max_life = 100
export var damage = 10
export var gain_exp = 200
var life = 100

onready var label_dmg = $label_damage
onready var tween_dmg = $Tween
var label_def_pos = Vector3.ZERO

func _ready():
	life = max_life
	animation = ANIM_WALK
	phasez_timer.start(1)
	phase_duration = randi() % 30
	if(phase_duration < 4):
		phase_duration = 4
	
	label_def_pos = label_dmg.transform.origin
	tween_dmg.interpolate_property(label_dmg, "translation", label_def_pos, label_def_pos + Vector3(0, 1, 0), 0.35,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween_dmg.interpolate_property(label_dmg, "scale", Vector3(1, 1, 1), Vector3(2, 2, 2), 0.35,Tween.TRANS_LINEAR,Tween.EASE_OUT)

func _process(_delta):
	match(state):
		KNOCKOUT:
			return
			
		PATROL:
			var tmp2 =  target_point - get_global_translation()
			if(tmp2.length() > 0.1):
				velocity = dir * speed
				velocity = move_and_slide(velocity, Vector3.UP)
			else:
				animation = ANIM_IDLE
				#velocity = Vector3.ZERO
				
			if(anim_player.get_current_animation() != animation):
				anim_player.play(animation)
		
		FIGHTING:
			if(GPlayerStatus.is_knockout):
				state = PATROL
				phasez_timer.start(1)
				return
			
			var tmp2 =  GPlayerStatus.player.get_global_translation() - get_global_translation()
			var distance = tmp2.length()
			
			dir = tmp2.normalized()
			var _rot = get_rotation()
			_rot.y = atan2(dir.x, dir.z)
			set_rotation(_rot)
			
			if(distance > 8):
				state = PATROL
				phasez_timer.start(1)
				speed = min_speed
			elif(distance > 3):
				velocity = dir * speed
				velocity = move_and_slide(velocity, Vector3.UP)
				animation = ANIM_RUN
			else:
				animation = ANIM_ATTACK
				#velocity = Vector3.ZERO
				
			if(anim_player.get_current_animation() != animation):
				anim_player.play(animation)

func take_hit(value = 1):
	if(state == KNOCKOUT):
		return
	label_dmg.visible = true
	label_dmg.text = String(value)
	tween_dmg.start()
	$Damage_effect.emitting = true
	
	#state = FIGHTING
	#phasez_timer.stop()
	
	life -= value
	if(life < 1):
		squash()

func squash():
	$CollisionShape.disabled = true
	$Area/CollisionShape.disabled = true
	$shadow_mesh.visible = false
	$Label3Dname.visible = false
	state = KNOCKOUT
	phasez_timer.stop()
	phasez_timer.start(12)
	anim_player.play(ANIM_KNOCKOUT)
	GPlayerStatus.add_expirence(gain_exp)
	BgLoader.current_scene.set_drops(get_global_translation())

func reset():
	speed = min_speed
	life = max_life
	$CollisionShape.disabled = false
	$Area/CollisionShape.disabled = false
	$shadow_mesh.visible = true
	$Label3Dname.visible = true
	visible = true
	animation = ANIM_WALK
	phasez_timer.start(2)
	state = PATROL

func on_range_attack():
	$Armature/Attack_effect.emitting = true
	GPlayerStatus.hit_player(damage)

func _on_Timer_timeout():
	match(state):
		KNOCKOUT:
			phasez_timer.stop()
			visible = false
			Gspawner.enemies.push_back(self)
			return
		
		PATROL:
			phasez_timer.start(phase_duration)
			animation = ANIM_WALK
			target_point = get_parent().get_rand_path_point()
			var tmp = target_point - get_global_translation()
			dir = tmp.normalized()
			var _rot = get_rotation()
			_rot.y = atan2(dir.x, dir.z)
			set_rotation(_rot)
			
		FIGHTING:
			pass

func _on_Tween_tween_all_completed():
	label_dmg.text = ""
	label_dmg.visible = false
	label_dmg.transform.origin = label_def_pos
	var tmp_xz = rand_range(-1, 1)
	tween_dmg.interpolate_property(label_dmg, "translation", label_def_pos, label_def_pos + Vector3(tmp_xz, 1, tmp_xz), 0.35,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween_dmg.interpolate_property(label_dmg, "scale", Vector3(1, 1, 1), Vector3(2, 2, 2), 0.35,Tween.TRANS_LINEAR,Tween.EASE_OUT)


func _on_Area_body_entered(_body):
	state = FIGHTING
	phasez_timer.stop()
	speed = max_speed

extends KinematicBody

enum { FIGHTING ,PATROL ,KNOCKOUT }

export var speed = 1.5
const ANIM_ATTACK:String = "attack"
const ANIM_IDLE:String = "pose"
const ANIM_WALK:String = "walk"
const ANIM_KNOCKOUT:String = "knockout"

var dir = Vector3.BACK
var velocity = Vector3.ZERO

onready var phasez_timer = $Timer

onready var anim_player = $AnimationPlayer
var animation = "pose"
var target_point = Vector3.ZERO
var phase_duration:int = 1

var state = PATROL
export var mname = "Mr Onion"
export var max_life = 100
export var damage = 10
export var gain_exp = 52
var life = 100

onready var col_shape = $CollisionShape
onready var dmg_effect = $Damage_effect
onready var mesh_shadow = $shadow
onready var dmg_3D = $Label3D
onready var tween = $Tween

var lpos = Vector3.ZERO

func _ready():
	life = max_life
	animation = ANIM_WALK
	phasez_timer.start(1)
	phase_duration = randi() % 30
	if(phase_duration < 4):
		phase_duration = 4
	
	lpos = dmg_3D.translation
	tween.interpolate_property(dmg_3D, "translation", lpos, lpos + Vector3(0.0, 1.5, 0.0), 0.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	

func _process(_delta):
	match(state):
		KNOCKOUT:
			return
			
		PATROL:
			var tmp2 =  target_point - global_transform.origin
			if(tmp2.length() > 1.0):
				velocity = dir * speed
				velocity = move_and_slide(velocity, Vector3.UP)
			else:
				animation = ANIM_IDLE
				velocity = Vector3.ZERO
				
			if(anim_player.get_current_animation() != animation):
				anim_player.play(animation)
		
		FIGHTING:
			if(GPlayerStatus.is_knockout):
				state = PATROL
				phasez_timer.start(1)
				return
			
			var tmp2 =  GPlayerStatus.player.global_transform.origin - global_transform.origin
			var distance = tmp2.length()
			
			dir = tmp2.normalized()
			var _rot = get_rotation()
			_rot.y = atan2(dir.x, dir.z)
			set_rotation(_rot)
			
			if(distance > 10):
				state = PATROL
				phasez_timer.start(1)
			elif(distance > 2):
				velocity = dir * speed
				velocity = move_and_slide(velocity, Vector3.UP)
				animation = ANIM_WALK
			else:
				animation = ANIM_ATTACK
				velocity = Vector3.ZERO
				
			if(anim_player.get_current_animation() != animation):
				anim_player.play(animation)

func _on_Timer_timeout():
	match(state):
		KNOCKOUT:
			phasez_timer.stop()
			visible = false
			GTimerSpawner.enemies.push_back(self)
			return
		
		PATROL:
			phasez_timer.start(phase_duration)
			animation = ANIM_WALK
			target_point = get_parent().get_rand_path_point()
			var tmp = target_point - global_transform.origin
			dir = tmp.normalized()
			var _rot = get_rotation()
			_rot.y = atan2(dir.x, dir.z)
			set_rotation(_rot)
			
		FIGHTING:
			pass
			
	
func take_hit(value = 1):
	if(state == KNOCKOUT):
		return
	
	dmg_3D.text = String(-value)
	tween.start()
	dmg_3D.visible = true
	dmg_effect.emitting = true
	
	state = FIGHTING
	phasez_timer.stop()
	
	life -= value
	if(life < 1):
		squash()
	
	GGeneral_Hud.display_info(self)

func squash():
	col_shape.disabled = true
	mesh_shadow.visible = false
	state = KNOCKOUT
	phasez_timer.stop()
	phasez_timer.start(12)
	anim_player.play(ANIM_KNOCKOUT)
	GPlayerStatus.add_expirence(gain_exp)
	GBgLoader.current_scene.set_drops(global_transform.origin)

func reset():
	life = max_life
	col_shape.disabled = false
	mesh_shadow.visible = true
	visible = true
	animation = ANIM_WALK
	phasez_timer.start(2)
	state = PATROL

func on_attack():
	GPlayerStatus.hit_player(damage)


func _on_Tween_tween_all_completed():
	dmg_3D.visible = false
	tween.interpolate_property(dmg_3D, "translation", lpos, lpos + Vector3(0.0, 1.5, 0.0), 0.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)

extends Area

onready var col_shape = $CollisionShape
var damage = 77
var is_used = false

func _ready():
	$CPUParticles.emitting = true
	$AnimationPlayer.play("New Anim")
	$Timer.start(0.5)
	$CPUParticles2.emitting = true
	pass

func detect_enemy():
	var bodies = get_overlapping_bodies()
	for bud in bodies:
		bud.take_hit(damage)

func _on_Timer_timeout():
	if not is_used:
		detect_enemy()
		is_used = true
		$Timer.start(3)
	else:
		queue_free()

extends Area

onready var col_shape = $CollisionShape
onready var ball = $Spatial
var damage = 77
var is_used = false

func _ready():
	$CPUParticles.emitting = true
	$Timer.start(0.5)
	pass

func detect_enemy():
	var bodies = get_overlapping_bodies()
	for bud in bodies:
		bud.take_hit(damage)

func _process(_delta):
	ball.scale.x +=  5 * _delta

func _on_Timer_timeout():
	if not is_used:
		detect_enemy()
		is_used = true
		$Timer.start(3)
	else:
		queue_free()

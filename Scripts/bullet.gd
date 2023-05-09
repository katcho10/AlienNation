extends Area

var speed = 10
var dir = Vector3.FORWARD
onready var col_shape = $CollisionShape
onready var rings = $Spatial
var damage = 135
var rot_axis = Vector3.ZERO

func _ready():
	rot_axis = Vector3(1.0, 1.0, 1.0).normalized()
	pass

func _process(_delta):
	translation += dir * speed * _delta
	rings.rotate(rot_axis, speed * _delta)

func _on_bullet_area_body_entered(body):
	visible = false
	col_shape.disabled = true
	body.take_hit(damage)


func _on_Timer_timeout():
	queue_free()

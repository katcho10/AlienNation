extends TouchScreenButton

var radius = Vector2(22, 22)
var boundary = 42
var ongoing_drag = -1

func _ready():
	pass

func get_button_pos():
	return position + radius

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_centre_distance = (event.position - get_parent().global_position).length()
		
		if event_centre_distance <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event.position - radius * global_scale)
		
			if get_button_pos().length() > boundary:
				set_position(get_button_pos().normalized() * boundary - radius)
				
			ongoing_drag = event.get_index()
			
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1


func _process(_delta):
	if ongoing_drag == -1:
		position = Vector2.ZERO - radius
#	if ongoing_drag == -1:
#		var pos_diff = (Vector2.ZERO - radius) - position
#		position += pos_diff * 20 * _delta

func get_direction():
	var tmp = get_button_pos().normalized()
	return Vector3(tmp.x, 0.0, tmp.y)
	

#for Area2D node 
#func _input(event):
#	if event is InputEventScreenTouch:
#		var distance = event.position.distance_to(big_circle.global_position)
#		if not touched:
#			if distance < max_distance:
#				touched = true
#		else:
#			small_circle.position = Vector2(0, 0)
#			touched = false

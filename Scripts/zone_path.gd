extends Path

#add a PathFollow node as a child of this node
#Set the propertise of PathFollow node 
#Rotation Mode to None and Cubic Interp to Off
onready var path_seeker = $PathFollow

func _ready():
	pass

func get_rand_path_point():
	path_seeker.unit_offset = randf()
	return path_seeker.global_transform.origin

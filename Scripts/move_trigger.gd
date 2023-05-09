extends Area

export(String, FILE, "*.tscn") var go_to_map
export var spawn_point = Vector3(0.0, 0.0, 0.0)
export var map_name:String = "No Where"

func _ready():
	$MeshInstance.call_deferred("queue_free")
	pass

func _on_door_body_entered(_body):
	GPlayerStatus.spawn_position = spawn_point
	GBgLoader.set_move_hud(go_to_map, map_name)

func _on_door_body_exited(_body):
	GBgLoader.unset_move_hud()

tool

extends Area2D

export(String, FILE)var next_scene_path = "" 



func _get_configuration_warning() -> String:
	if next_scene_path == "":
		return "next_scene_path must be set for the portal to work "
	else:
			return ""

func _on_portal_body_entered(body):
	if get_tree().change_scene(next_scene_path) != OK:
		
		print("Error: Unavailable scene!")
	


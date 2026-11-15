extends Node2D
@export var game_over_scene: PackedScene

func _process(delta: float) -> void:
	if ($Enemies).get_child_count() <= 0:
		get_tree().change_scene_to_packed(game_over_scene)
	if $Player.health <= 0:
		get_tree().change_scene_to_packed(game_over_scene)

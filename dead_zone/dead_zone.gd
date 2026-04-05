extends Node

var player_death_effect = preload("res://player/player_death_effect/player_death_effect.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.player_death()

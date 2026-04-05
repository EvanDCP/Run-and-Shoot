extends Node

@export var health_amount : int = 3
@export var damage_amount : int = 1

var enemy_death_effect = preload("res://enemies/enemy_death_effect.tscn")

func _on_hurtbox_area_entered(area: Area2D) -> void:
	print("Hurtbox area entered")
	if area.get_parent().has_method("get_damage_amount"): # “Est-ce que cet objet bullet a une fonction appelée get_damage_amount ?
		var node = area.get_parent() as Node # area.get_parent() = Bullet
		health_amount -= node.damage_amount # damage_amount c'est le return de ma fonction get_damage_amount dans bullet
		print("Health amount: ", health_amount)

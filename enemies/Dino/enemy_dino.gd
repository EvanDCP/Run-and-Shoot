extends CharacterBody2D

@export var health_amount : int = 5
@export var damage_amount : int = 1

var enemy_death_effect = preload("res://enemies/enemy_death_effect.tscn")

func _on_hurtbox_area_entered(area: Area2D):
	print("Hurtbox area entered")
	if area.get_parent().has_method("get_damage_amount"): # “Est-ce que cet objet bullet a une fonction appelée get_damage_amount ?
		var node = area.get_parent() as Node # area.get_parent() = Bullet
		health_amount -= node.damage_amount # damage_amount c'est le return de ma fonction get_damage_amount dans bullet
		print("Health amount: ", health_amount)
		
		if health_amount <= 0 :
			var enemy_death_effect_instance = enemy_death_effect.instantiate() as Node2D
			enemy_death_effect_instance.global_position = global_position # position de l'effet = position du crab
			get_parent().add_child(enemy_death_effect_instance) # on ajoute l'effet de mort en tant que noeud enfant au parent de ce script (ici enemy dino)
			queue_free() # détruit le dino
	else:
		print("No method")

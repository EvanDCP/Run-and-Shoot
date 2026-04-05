extends CharacterBody2D

var enemy_death_effect = preload("res://enemies/enemy_death_effect.tscn")

@export var patrol_points : Node
@export var speed : int = 4000
@export var wait_time : int = 3
@export var health_amount : int = 3
@export var damage_amount : int = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer

const GRAVITY = 1000

enum State { Idle, Walk }
var current_state : State
var direction : Vector2 = Vector2.LEFT
var number_of_points : int # nombre total de points de patrouille.
var point_positions : Array[Vector2] # liste contenant les coordonnées (Vector2) de chaque point.
var current_point : Vector2 # le point actuel que l’ennemi vise.
var current_point_position : int # l’index du point actuel dans la liste.
var can_walk : bool # booléen qui contrôle si l’ennemi peut marcher (false = il attend).


func _ready():
	if patrol_points != null: # Vérifie si tu as bien ajouté des points de patrouille.
		number_of_points = patrol_points.get_children().size() # get_children() → récupère tous les points enfants du node patrol_points.
		for point in patrol_points.get_children(): 
			point_positions.append(point.global_position) # append(point.global_position) → ajoute la position de chaque point dans la liste point_positions.
		current_point = point_positions[current_point_position] # current_point → initialisé au premier point (current_point_position commence à 0).
	else:
		print("No patrol points")
		
	timer.wait_time = wait_time
	
	current_state = State.Idle

func _process(delta: float):
		enemy_gravity(delta)
		enemy_idle(delta) 
		enemy_walk(delta)
		
		move_and_slide() # s’occupe ensuite de déplacer le personnage en prenant en compte les collisions.
		
		enemy_animation()

func enemy_gravity(delta : float):
	velocity.y += GRAVITY * delta
	
func enemy_idle(delta : float):
	if can_walk == false:
		velocity.x = move_toward(velocity.x, 0, speed * delta) # ralentit la vitesse jusqu’à 0.
		current_state = State.Idle

func enemy_walk(delta : float):
	if can_walk == false:
		return
	
	# Vérifie si l’ennemi n’est pas encore arrivé au point :
	if abs(position.x - current_point.x) > 0.5 : # 
		velocity.x = direction.x * speed * delta # distance par rapport au point actuel.
		current_state = State.Walk
	else: # Si l’ennemi est arrivé au point 
		current_point_position += 1 # Passe au point suivant
	
		if current_point_position >= number_of_points : # Si on dépasse le dernier point, revient au premier (boucle).
			current_point_position = 0
			
		current_point = point_positions[current_point_position]; # Met à jour current_point avec la nouvelle cible.
		
		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT
			
		can_walk = false
		timer.start()
	
	animated_sprite_2d.flip_h = direction.x > 0

func enemy_animation():
	if current_state == State.Idle && !can_walk:
		animated_sprite_2d.play("idle")
	elif current_state == State.Walk && can_walk:
		animated_sprite_2d.play("walk")

func _on_timer_timeout():
	can_walk = true


func _on_hurtbox_area_entered(area : Area2D): # area = la zone de collision qui a touché l’ennemi
	print("Hurtbox area entered") 
	if area.get_parent().has_method("get_damage_amount"): # “Est-ce que cet objet bullet a une fonction appelée get_damage_amount ?
		var node = area.get_parent() as Node # area.get_parent() = Bullet
		health_amount -= node.damage_amount # damage_amount c'est le return de ma fonction get_damage_amount dans bullet
		print("Health amount: ", health_amount)
		
		if health_amount <= 0 :
			var enemy_death_effect_instance = enemy_death_effect.instantiate() as Node2D
			enemy_death_effect_instance.global_position = global_position # position de l'effet = position du crab
			get_parent().add_child(enemy_death_effect_instance) # on ajoute l'effet de mort en tant que noeud enfant au parent de ce script (ici enemy crab)
			queue_free() # détruit le crab

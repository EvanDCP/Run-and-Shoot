class_name NodeState
extends Node

# EnemyDino est un CharacterBody2d, c'est lui qui a une position, une vitesse (velocity), bouge avec move_and_slide,etc

# StateMachineController c'est le script qui écoute les événements. Exemple le joueurs entre ou sort de la zone d'attaque
# puis dis à la machine : passe en attack ou passe en idle

# StateMAchine c'est le cerveau central, il garde en mémoire quel état est actif quel état doit etre appelé a chaque frame

func on_process(delta : float) :
	pass
	
func on_physics_process(delat : float) :
	pass

func enter():
	pass
	
func exit():
	pass

extends Node2D

@export var pickup_amount : int = 1


func _on_health_pickup_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and HealthManager.current_health < 3:
		HealthManager.increase_health(pickup_amount)
		queue_free()
		

extends CanvasLayer

func _ready() -> void:
	get_tree().paused = false

func _on_respawn_button_pressed() -> void:
	get_tree().paused = false
	SceneManager.transition_to_current_scene()
	queue_free()


func _on_main_menu_button_pressed() -> void:
	GameManager.main_menu()
	queue_free()

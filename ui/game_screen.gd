extends CanvasLayer

@onready var collectible_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/CollectibleLabel


func _ready() -> void:
	CollectiblesManager.on_collectible_award_received.connect(on_collectible_award_received)
	
func on_collectible_award_received(total_award : int):
	collectible_label.text = str(total_award)


func _on_pause_texture_button_pressed() -> void:
	GameManager.pause_game()

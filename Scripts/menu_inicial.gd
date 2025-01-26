extends Control

@onready var home: Panel = $Home

@onready var dificulty_selector: Panel = $DificultySelector

@onready var how_to_play: Panel = $HowToPlay

@onready var options: Panel = $Options

@onready var dificulty_description: Label = $DificultySelector/DificultyDescription

func _on_start_game_button_up() -> void:
	home.visible = false
	dificulty_selector.visible = true

	


func _on_how_button_button_up() -> void:
	home.visible = false
	how_to_play.visible = true


func _on_how_to_back_button_up() -> void:
	home.visible = true
	how_to_play.visible = false


func _on_options_button_up() -> void:
	home.visible = false
	options.visible = true



func _on_easy_button_up() -> void:
	Config.dificulty = Config.DIFICULTY.EASY
	dificulty_description.text = tr("EASY_DESCRIPTION")


func _on_medium_button_up() -> void:
	Config.dificulty = Config.DIFICULTY.MEDIUM
	dificulty_description.text = tr("MEDIUM_DESCRIPTION")


func _on_hard_button_up() -> void:
	Config.dificulty = Config.DIFICULTY.HARD
	dificulty_description.text = tr("HARD_DESCRIPTION")


func _on_start_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_options_back_button_up() -> void:
	home.visible = true
	options.visible = false


func _on_english_button_up() -> void:
	TranslationServer.set_locale("en")
	
func _on_portuguese_button_up() -> void:
	TranslationServer.set_locale("pt")

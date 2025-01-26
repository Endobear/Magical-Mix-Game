class_name Potion
extends Button

enum COLORS {RED,GREEN,BLUE,NEUTRO}

@onready var original_positon := position

@export var color : COLORS
var intensity : float
@onready var liquido: Sprite2D = $Node2D/Liquido

@onready var animation_player: AnimationPlayer = $AnimationPlayer



@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
	$Node2D/Neutralizador.visible = false
	match color:
		COLORS.RED:
			color_rect.color = Color.RED
		COLORS.GREEN:
			color_rect.color = Color.GREEN
		COLORS.BLUE:
			color_rect.color = Color.BLUE
		COLORS.NEUTRO:
			$Node2D/Frasco.visible = false
			$Node2D/Liquido.visible = false
			$Node2D/Neutralizador.visible = true
	liquido.modulate = color_rect.color
	intensity = Config.get_modifier()

	


func _on_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Node2D, "scale", Vector2(2.705,2.705),0.3)
	


func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Node2D, "scale", Vector2(2.345,2.345),0.3)

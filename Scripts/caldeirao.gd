class_name Caldeirao
extends Button

var recipe : Recipe = Recipe.new()

@onready var color_rect: ColorRect = $ColorRect

@onready var bolhas: Node2D = $Bolhas

@onready var caldeirao: Sprite2D = $Caldeirao


func add_potion(potion : Potion):
	match potion.color:
		potion.COLORS.RED:
			recipe.color.r = clampf(recipe.color.r + potion.intensity,0,1)
		potion.COLORS.GREEN:
			recipe.color.g = clampf(recipe.color.g + potion.intensity,0,1)
		potion.COLORS.BLUE:
			recipe.color.b = clampf(recipe.color.b + potion.intensity,0,1)
		potion.COLORS.NEUTRO:
			reset_potion()
			return
		
	bolhas.modulate = recipe.color

func reset_potion():
	recipe.color = Color.BLACK
	bolhas.modulate = Color.WHITE


func _on_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(caldeirao, "scale", Vector2(2.705,2.705),0.3)


func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(caldeirao, "scale", Vector2(2.579,2.579),0.3)

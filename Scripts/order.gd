extends Control


@onready var color: ColorRect = $Node2D/Color
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var recipe : Recipe
var is_current : bool = false
@onready var cliente: AnimatedSprite2D = $Node2D/ClienteSemcor

func appear():
	cliente.play(["1","2","3","4"].pick_random())
	animation_player.play("Appear")
	is_current = true
	
func dissapear():
	animation_player.play("Dissapear")
	await  animation_player.animation_finished
	is_current = false

func set_order(order : Recipe):
	recipe = order
	color.color = recipe.color

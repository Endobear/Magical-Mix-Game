extends Node2D

@onready var timer_label: Label = $Control/TimerLabel

var running : bool = true

var selection : Potion
var goal : Recipe

var pontos : int = 0
@onready var potion_shelf = $PotionShelf
@onready var caldeirao: Caldeirao = $Caldeirao
@onready var points: Label = $Control/Points

@onready var order_spawn = $OrderSpawn/VBoxContainer

@onready var next_order_timer: Timer = $NextOrderTimer
@onready var game_run: Timer = $GameRun


@onready var game_over: Panel = $GameOver

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var bubble_sfx = [preload("res://SFX/bubbles-single2.wav"),preload("res://SFX/bubbles-single1.wav")]
var completion_sfx = preload("res://SFX/Rise01.wav")

var orders : Array[Control]
const ORDER = preload("res://Scenes/order.tscn")

func _ready() -> void:
	running = true
	
	for child in potion_shelf.get_children():
		if child is Potion:
			child.button_up.connect(select_potion.bind(child))
			
	for child in potion_shelf.get_child(0).get_children():
		if child is Potion:
			child.button_up.connect(select_potion.bind(child))
	for i in range(3):
		var order = ORDER.instantiate()
		order_spawn.add_child(order)
		orders.append(order)
	generate_recipe()
	
	
func _process(delta: float) -> void:
	var minutes := game_run.time_left / 60
	var seconds := fmod(game_run.time_left,60)
	#print(str(int(minutes)) + ":" + "%02d" % (int(seconds)))
	timer_label.text = str(int(minutes)) + ":" + "%02d" % (int(seconds))
	points.text = "%02d" % pontos
	
func select_potion(potion : Potion):
	if selection:
		selection.animation_player.play("Unselect")
	selection = potion
	selection.animation_player.play("Selected")
	print("uga")
	
func generate_recipe():
	
	for order in orders:
		if !order.is_current:
	
			goal = Recipe.new()
			var red = Config.get_modifier() * randi_range(0,Config.get_samples())
			var blue = Config.get_modifier() * randi_range(0,Config.get_samples())
			var green = Config.get_modifier() * randi_range(0,Config.get_samples())
			goal.color = Color(red,green,blue)
			order.set_order(goal)
			order.appear()
			return
		
	
	
	

func _on_caldeirao_button_up() -> void:
	if selection:
		print("Adding " + selection.name) 
		caldeirao.add_potion(selection)
		selection.animation_player.play("Unselect")
		audio_stream_player.stream = bubble_sfx.pick_random()
		audio_stream_player.pitch_scale = 1.0
		audio_stream_player.pitch_scale = randf_range(0.9,1.1)
		audio_stream_player.play()
		
		selection = null
		
	if running:
		for order in orders:
			if order.is_current:
				print(order.recipe.color)
				if order.recipe.color == caldeirao.recipe.color:
					print("order cleared")
					game_run.start(game_run.time_left + (90 - game_run.time_left) / 10 )
					pontos += 1
					order.dissapear()
					caldeirao.reset_potion()
					audio_stream_player.stream = completion_sfx
					audio_stream_player.pitch_scale = 1.0
					audio_stream_player.play()
					
		


func _on_next_order_timer_timeout() -> void:
	if running:
		generate_recipe()
		next_order_timer.wait_time = randf_range(5,10)


func _on_game_run_timeout() -> void:
	print("Acabou")
	running = false
	game_over.visible = true
	$GameOver/PointsOver.text = points.text
	for order in orders:
		if order.is_current:
			order.dissapear()
	var tween = get_tree().create_tween()
	tween.tween_property($Music,"volume_db",-100,10)


func _on_menu_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/MenuInicial.tscn")

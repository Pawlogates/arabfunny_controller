extends Node2D

@export var disable_showcase = false

@onready var player = $example_playerScene
@onready var arabfunny_controller = $arabfunny_controller

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	$deleteThis_info.queue_free()

var deleteThis_anim_cancel = false
func _process(delta: float) -> void:
	#DELETE THIS ITS JUST FOR SHOWING HOW IT SPAWNS AROUND A PLAYER NODE SO
	#THAT YOU CAN HAVE THIS ON DURING GAMEPLAY BECAUSE UHHHHHH
	if not disable_showcase:
		if camera_zoomOut:
			$Camera2D.zoom = $Camera2D.zoom.move_toward(Vector2(0.3, 0.3), delta)
			if not deleteThis_anim_cancel:
				player.animplayer.play("move")
				player.visible = true
				deleteThis_anim_cancel = true
		else:
			$Camera2D.zoom = $Camera2D.zoom.move_toward(Vector2(1, 1), delta)
			player.animplayer.play("RESET")
			player.visible = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.is_action_pressed("ui_up"):
			get_tree().reload_current_scene()
			return
		
		if get_tree().paused == true:
			get_tree().paused = false
		elif get_tree().paused == false:
			get_tree().paused = true
	
	elif Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()
			return
	
	elif Input.is_action_just_pressed("pause"):
		if get_tree().paused == true:
			get_tree().paused = false
		elif get_tree().paused == false:
			get_tree().paused = true
	
	elif Input.is_action_just_pressed("ui_accept"):
		if Input.is_action_pressed("ui_up"):
			var meme_spawner2 = preload("res://Meme Mode/memeMode_secondary_spawner.tscn").instantiate()
			meme_spawner2.randomize_all = true
			meme_spawner2.position = Vector2($arabfunny_controller.spawn_around_this_node.position.x + randi_range(-800, 800), $arabfunny_controller.spawn_around_this_node.position.y + randi_range(-500, 500))
			$arabfunny_controller.add_child(meme_spawner2)
		else:
			var meme_spawner = preload("res://Meme Mode/memeMode_image_spawner.tscn").instantiate()
			meme_spawner.randomize_all = true
			meme_spawner.position = Vector2($arabfunny_controller.spawn_around_this_node.position.x + randi_range(-800, 800), $arabfunny_controller.spawn_around_this_node.position.y + randi_range(-500, 500))
			$arabfunny_controller.add_child(meme_spawner)
	
	elif Input.is_action_just_pressed("spawn1"):
		var meme_spawner = preload("res://Meme Mode/memeMode_image_spawner.tscn").instantiate()
		meme_spawner.randomize_all = true
		meme_spawner.position = Vector2($arabfunny_controller.spawn_around_this_node.position.x + randi_range(-800, 800), $arabfunny_controller.spawn_around_this_node.position.y + randi_range(-500, 500))
		$arabfunny_controller.add_child(meme_spawner)
	
	elif Input.is_action_just_pressed("spawn2"):
		var meme_spawner2 = preload("res://Meme Mode/memeMode_secondary_spawner.tscn").instantiate()
		meme_spawner2.randomize_all = true
		meme_spawner2.position = Vector2($arabfunny_controller.spawn_around_this_node.position.x + randi_range(-800, 800), $arabfunny_controller.spawn_around_this_node.position.y + randi_range(-500, 500))
		$arabfunny_controller.add_child(meme_spawner2)
	
	elif Input.is_action_just_pressed("next"):
		$background_video_player.randomize_video()


var camera_zoomOut = false
func _on_delete_this_camera_zoom_delay_timeout() -> void:
	if not disable_showcase:
		camera_zoomOut = true
		arabfunny_controller.show_spawners = true

func _on_delete_this_camera_back_delay_timeout() -> void:
	if not disable_showcase:
		camera_zoomOut = false
		arabfunny_controller.show_spawners = false

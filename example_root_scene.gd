extends Node2D

@onready var spawn_around_this_node = $example_playerScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	$meme_mode_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#DELETE THIS ITS JUST FOR SHOWING HOW IT SPAWNS AROUND A PLAYER NODE SO
	#THAT YOU CAN HAVE THIS ON DURING GAMEPLAY BECAUSE UHHHHHH
	if camera_zoomOut:
		$Camera2D.zoom = $Camera2D.zoom.move_toward(Vector2(0.3, 0.3), delta)
		spawn_around_this_node.animplayer.play("move")
		spawn_around_this_node.visible = true
	else:
		$Camera2D.zoom = $Camera2D.zoom.move_toward(Vector2(1, 1), delta)
		spawn_around_this_node.animplayer.play("RESET")
		spawn_around_this_node.visible = false

func _on_meme_mode_timer_timeout():
	var meme_spawner = preload("res://Meme Mode/memeMode_image_spawner.tscn").instantiate()
	meme_spawner.randomize_all = true
	print(spawn_around_this_node.position)
	meme_spawner.position = Vector2(spawn_around_this_node.position.x + randi_range(-800, 800), spawn_around_this_node.position.y + randi_range(-500, 500))
	add_child(meme_spawner)
	
	$meme_mode_timer.wait_time = randf_range(0.5, 6)
	$meme_mode_timer.start()


var camera_zoomOut = false
func _on_delete_this_camera_zoom_delay_timeout() -> void:
	camera_zoomOut = true


func _on_delete_this_camera_back_delay_timeout() -> void:
	camera_zoomOut = false

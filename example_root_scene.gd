extends Node2D

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

var camera_zoomOut = false
func _on_delete_this_camera_zoom_delay_timeout() -> void:
	camera_zoomOut = true
	arabfunny_controller.show_spawners = true

func _on_delete_this_camera_back_delay_timeout() -> void:
	camera_zoomOut = false
	arabfunny_controller.show_spawners = false

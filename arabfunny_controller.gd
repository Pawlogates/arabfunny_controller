extends Node2D

@export var spawnAroundThisNode_name = "example_playerScene"
var spawn_around_this_node : Node

@onready var settings = $Settings
#@onready var settings = $/root/example_rootScene/arabfunny_controller/Settings

var show_spawners = false #debug

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_around_this_node = get_parent().get_node(spawnAroundThisNode_name)
	
	$meme_mode_timer.wait_time = randf_range(0.25, 4)
	$meme_mode_timer.start()
	
	$meme_mode_timer2.wait_time = randf_range(0.5, 8)
	$meme_mode_timer2.start()
	
	$meme_mode_timer3.wait_time = randf_range(1, 16)
	$meme_mode_timer3.start()
	
	$restart_timer.wait_time = randf_range(6, 240)
	$restart_timer.start()
	
	$delete_items_timer.wait_time = randf_range(3, 120)
	$delete_items_timer.start()
	
	$image_static.wait_time = randf_range(0.25, 4)
	$image_static.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#MAIN MEME SPAWNER, ALMOST EVERYTHING COMES FROM HERE.
func _on_meme_mode_timer_timeout():
	var meme_spawner = preload("res://Meme Mode/memeMode_image_spawner.tscn").instantiate()
	meme_spawner.randomize_all = true
	meme_spawner.position = Vector2(spawn_around_this_node.position.x + randi_range(-800, 800), spawn_around_this_node.position.y + randi_range(-500, 500))
	#debug
	if show_spawners : meme_spawner.color_rect_visible = true #Useless visual showing where the meme spawner appeared.
	#debug
	add_child(meme_spawner)
	
	$meme_mode_timer.wait_time = randf_range(0.5, 6 * settings.main_rate) # default: 0.5, 6
	$meme_mode_timer.start()

# SECONDARY MEME SPAWNER, WHICH SPAWNS RED CIRCLES AND ARROWS, AS WELL AS VARIOUS TEXT.
func _on_meme_mode_timer_2_timeout() -> void:
	var meme_spawner2 = preload("res://Meme Mode/memeMode_secondary_spawner.tscn").instantiate()
	meme_spawner2.randomize_all = true
	meme_spawner2.position = Vector2(spawn_around_this_node.position.x + randi_range(-800, 800), spawn_around_this_node.position.y + randi_range(-500, 500))
	#debug
	if show_spawners : meme_spawner2.color_rect_visible = true #Useless visual showing where the meme spawner appeared.
	#debug
	add_child(meme_spawner2)
	
	$meme_mode_timer2.wait_time = randf_range(0.5, 6 * settings.secondary_rate) # default: 0.5, 6
	$meme_mode_timer2.start()


var video_scene = preload("res://Meme Mode/memeMode_video.tscn")
var video_filepath : String

func _on_meme_mode_timer_3_timeout() -> void:
	var video = video_scene.instantiate()
	video.major = true
	video.pivot_offset = Vector2(video.size.x / 2, video.size.y / 2)
	video.position += Vector2(0, 0)
	video.scale = Vector2(randf_range(0.8, 2), randf_range(0.8, 2))
	video.volume_db = randi_range(-10, 20)
	video.material = preload("res://Meme Mode/remove_green.tres")
	video.scale += Vector2(2, 2)
	
	var rolled_is_position_offset = randi_range(0, 3)
	if rolled_is_position_offset == 3:
		video.position += Vector2(randi_range(-1000, 1000), randi_range(-600, 600))
	var rolled_is_rotated = randi_range(0, 3)
	if rolled_is_rotated == 3:
		video.rotation_degrees = randf_range(-360, 360)
	var rolled_is_scaled = randi_range(0, 3)
	if rolled_is_scaled == 3:
		video.scale += Vector2(randf_range(-2, 1), randf_range(-2, 1))
	
	get_parent().add_child(video)
	
	$meme_mode_timer3.wait_time = randf_range(3, 24 * settings.major_greenscreen_rate) # default: 3, 24
	$meme_mode_timer3.start()


func _on_restart_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _on_delete_items_timer_timeout() -> void:
	for item in get_tree().get_nodes_in_group("spawner_main") + get_tree().get_nodes_in_group("spawner_secondary") + get_tree().get_nodes_in_group("item_main") + get_tree().get_nodes_in_group("item_secondary"):
		item.queue_free()
	
	$delete_items_timer.wait_time = randf_range(3, 90)
	$delete_items_timer.start()


func _on_image_static_timeout() -> void:
	var meme_spawner = preload("res://Meme Mode/memeMode_image_spawner.tscn").instantiate()
	meme_spawner.randomize_all = false
	meme_spawner.position = Vector2(spawn_around_this_node.position.x + randi_range(-800, 800), spawn_around_this_node.position.y + randi_range(-500, 500))
	meme_spawner.only_one = true
	meme_spawner.fall_down = false
	meme_spawner.rotates = true
	
	var img_total = settings.total_common
	var rolled_img = randi_range(1, img_total)
	while img_total > 0:
		if rolled_img == img_total:
			var file_path = "res://Meme Mode/pictures/common/" + str(img_total)
			var file_type : String
			if ResourceLoader.exists(file_path + ".png"):
				file_type = ".png"
			elif ResourceLoader.exists(file_path + ".jpg"):
				file_type = ".jpg"
			elif ResourceLoader.exists(file_path + ".jpeg"):
				file_type = ".jpeg"
			
			print("loading file: " + file_path + file_type)
			meme_spawner.image_filepath = file_path + file_type
		
		img_total -= 1
	
	add_child(meme_spawner)
	
	$image_static.wait_time = randf_range(0.25, 8 * settings.main_rate)
	$image_static.start()

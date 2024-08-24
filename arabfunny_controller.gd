extends Node2D

@export var spawnAroundThisNode_name = "example_playerScene"
var spawn_around_this_node : Node

var show_spawners = false #debug

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$meme_mode_timer.start()
	spawn_around_this_node = get_parent().get_node(spawnAroundThisNode_name)


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
	
	$meme_mode_timer.wait_time = randf_range(0.5, 6) # default: 0.5, 6
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
	
	$meme_mode_timer2.wait_time = randf_range(0.5, 6) # default: 0.5, 6
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
	get_parent().add_child(video)
	
	$meme_mode_timer3.wait_time = randf_range(3, 24) # default: 3, 24
	$meme_mode_timer3.start()

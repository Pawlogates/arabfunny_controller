extends CharacterBody2D

var image_filepath : String = "res://Meme Mode/pictures/5.jpg"

var isBasicEmojiSpam = false

var opacity_fade_out = true
var scale_down = false
var rotates = false

var z_index_value = 50

var rotate_deg = 0

var scale_x = 1
var scale_y = 1

var vel_x = 0
var vel_y = 0

var fall_down = true

var rotate_speed = 1
var rotate_left = false

var rotate_direction = 1

var frozen = false

var anim_scale_loop = false

var is_video = false
var video_filepath = preload("res://Meme Mode/videos/1.ogv")
var is_video_quick = false
var video_quick_filepath = preload("res://Meme Mode/videos/1.ogv")

var video_randomize = true
var video_foreground = true

var video_scene = preload("res://Meme Mode/memeMode_video.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if anim_scale_loop:
		$AnimationPlayer.speed_scale = randf_range(0.2, 1.4)
		$AnimationPlayer.play("scaleLoop")
		scale = Vector2(randf_range(0.8, 3), randf_range(0.8, 2.4))
	
	if not anim_scale_loop and not is_video and not is_video_quick:
		if not scale_down:
			scale = Vector2(0.01, 0.01)
	
	if rotate_left:
		rotate_direction = -1
	else:
		rotate_direction = 1
	
	$image.texture = load(image_filepath)
	z_index = z_index_value
	
	if not isBasicEmojiSpam:
		velocity = Vector2(randi_range(-500, 500), randi_range(-500, 250))
		scale.x = scale_x
		scale.y = scale_y
	else:
		velocity = Vector2(randi_range(-400, 400), randi_range(-400, 50))
		scale = Vector2(0.05, 0.05)
		modulate.a = 0
	
	if is_video:
		if video_randomize:
			var video_total = 13
			var rolled_video = randi_range(1, video_total)
			while video_total > 0:
				if rolled_video == video_total:
					var file_path = "res://Meme Mode/videos/" + str(video_total)
					var file_type : String
					if ResourceLoader.exists(file_path + ".ogv"):
						file_type = ".ogv"
					
					print("loading file: " + file_path + file_type)
					video_filepath = file_path + file_type
				
				video_total -= 1
	
	if is_video_quick and not is_video:
		var rolled_frozen = randi_range(0, 1)
		if rolled_frozen:
			frozen = true
		
		if video_randomize:
			var x = randi_range(0, 1)
			if x:
				var video_total = 15
				var rolled_video = randi_range(1, video_total)
				while video_total > 0:
					if rolled_video == video_total:
						var file_path = "res://Meme Mode/videos/gifs/" + str(video_total)
						var file_type : String
						if ResourceLoader.exists(file_path + ".ogv"):
							file_type = ".ogv"
						
						print("loading file: " + file_path + file_type)
						video_filepath = file_path + file_type
					
					video_total -= 1
			else:
				var video_total = 16
				var rolled_video = randi_range(1, video_total)
				while video_total > 0:
					if rolled_video == video_total:
						var file_path = "res://Meme Mode/videos/greenscreens/" + str(video_total)
						var file_type : String
						if ResourceLoader.exists(file_path + ".ogv"):
							file_type = ".ogv"
						
						print("loading file: " + file_path + file_type)
						video_filepath = file_path + file_type
					
					video_total -= 1
	
	if is_video or is_video_quick:
		var video = video_scene.instantiate()
		video.position += Vector2(-350, -200)
		video.scale = Vector2(randf_range(0.8, 2), randf_range(0.8, 2))
		video.stream = load(video_filepath)
		video.volume_db = randi_range(-10, 20)
		video.pivot_offset = Vector2(video.size.x / 2, video.size.y / 2)
		if video_foreground : video.z_index = randi_range(50, 125)
		if video_filepath.contains("greenscreens"):
			video.material = preload("res://Meme Mode/remove_green.tres")
			video.scale += Vector2(2, 2)
		$image.add_child(video)
		$image.self_modulate.a = 0
	
	if is_video_quick and not is_video:
		await get_tree().create_timer(randf_range(1, 8), false).timeout
	else:
		await get_tree().create_timer(randf_range(5, 30), false).timeout
	
	queue_free()


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if frozen:
		return
	if anim_scale_loop or is_video:
		return
	
	if fall_down:
		velocity.y += gravity / 2 * delta
	
	if scale_down:
		scale = scale.move_toward(Vector2(0.01, 0.01), delta / 2)
	else:
		scale = scale.move_toward(Vector2(0.6 * scale_x, 0.6 * scale_y), delta)
	
	if scale.x < 0.03 and scale.y < 0.03 : queue_free()
	
	if opacity_fade_out:
		modulate.a = move_toward(modulate.a, 0, delta / 5)
	else:
		modulate.a = move_toward(modulate.a, 1, delta * 2)
	
	if rotates:
		rotation_degrees = move_toward(rotation_degrees, randf_range(-1, 5) * 1000 * rotate_direction, delta * 10 * rotate_speed)
	
	move_and_slide()

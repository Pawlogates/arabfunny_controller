extends Node2D

@onready var settings : Node

var color_rect_visible = false #DEBUG

var meme_scene = preload("res://Exponaut Components/Other/Game Modes/Meme Mode/memeMode_image.tscn")

var randomize_all = false

var isBasicEmojiSpam = false

var image_filepath = "res://Exponaut Components/Other/Game Modes/Meme Mode/pictures/5.jpg"
var sound_filepath = "res://Exponaut Components/Other/Game Modes/Meme Mode/audio/1.mp3"
var music_filepath = "res://Exponaut Components/Other/Game Modes/Meme Mode/audio/music/1.mp3"

var opacity_fade_out = true
var scale_down = false
var rotates = false

var rotate_deg = 0

var scale_x = 1
var scale_y = 1

var vel_x = 0
var vel_y = 0

var z_index_value = 50

var fall_down = true

var rotate_speed = 1
var rotate_left = false

var anim_scale_loop = false

var is_video = false
var video_foreground = false

var is_video_quick
var video_quick_foreground = false

var only_one = false
var sfx_only_one = true

# Called when the node enters the scene tree for the first time.
func _ready():
	settings = get_tree().get_first_node_in_group("meme_mode_settings")
	
	#DEBUG
	if color_rect_visible:
		$ColorRect.visible = true
	#DEBUG END
	
	if randomize_all:
		#CHANCE TO BE A BASIC FALLING IMAGE SPAM, IGNORING MOST PROPERTIES.
		var rolled_isBasicEmojiSpam = randi_range(0, 1)
		if rolled_isBasicEmojiSpam == 1:
			isBasicEmojiSpam = true
		else:
			isBasicEmojiSpam = false
		
		var rolled_video = randi_range(0, 2)
		if rolled_video == 2:
			is_video = true
		else:
			is_video = false
		
		var rolled_video_quick = randi_range(0, 1)
		if rolled_video_quick == 1:
			is_video_quick = true
		else:
			is_video_quick = false
		
		var rolled_video_foreground = randi_range(0, 2)
		if rolled_video_foreground == 2:
			video_foreground = true
		else:
			video_foreground = false
		
		var rolled_anim_scale_loop = randi_range(0, 1)
		if rolled_anim_scale_loop == 1:
			anim_scale_loop = true
		else:
			anim_scale_loop = false
		
		var rolled_sfx_only_one = randi_range(0, 3)
		if rolled_sfx_only_one != 3:
			sfx_only_one = true
		else:
			sfx_only_one = false
		
		$Timer2.wait_time = randf_range(0.5, 12)
		$Timer2.start()
		
		$Timer3.wait_time = randf_range(0.1, 0.3)
		$Timer3.start()
		
		if randi_range(0, 1):
			var img_total = settings.total_pictures
			var rolled_img = randi_range(1, img_total)
			while img_total > 0:
				if rolled_img == img_total:
					var file_path = "res://Exponaut Components/Other/Game Modes/Meme Mode/Meme Mode/pictures/" + str(img_total)
					var file_type : String
					if ResourceLoader.exists(file_path + ".png"):
						file_type = ".png"
					elif ResourceLoader.exists(file_path + ".jpg"):
						file_type = ".jpg"
					elif ResourceLoader.exists(file_path + ".jpeg"):
						file_type = ".jpeg"
					
					print("loading file: " + file_path + file_type)
					image_filepath = file_path + file_type
				
				img_total -= 1
		
		else:
			var img_total = settings.total_common
			var rolled_img = randi_range(1, img_total)
			while img_total > 0:
				if rolled_img == img_total:
					var file_path = "res://Exponaut Components/Other/Game Modes/Meme Mode/Meme Mode/pictures/common/" + str(img_total)
					var file_type : String
					if ResourceLoader.exists(file_path + ".png"):
						file_type = ".png"
					elif ResourceLoader.exists(file_path + ".jpg"):
						file_type = ".jpg"
					elif ResourceLoader.exists(file_path + ".jpeg"):
						file_type = ".jpeg"
					
					print("loading file: " + file_path + file_type)
					image_filepath = file_path + file_type
				
				img_total -= 1
		
		
		var total_sfx = settings.total_audio
		var rolled_sfx = randi_range(1, total_sfx)
		while total_sfx > 0:
			if rolled_sfx == total_sfx:
				var file_path = "res://Exponaut Components/Other/Game Modes/Meme Mode/Meme Mode/audio/" + str(total_sfx)
				var file_type : String
				if ResourceLoader.exists(file_path + ".mp3"):
					file_type = ".mp3"
				elif ResourceLoader.exists(file_path + ".wav"):
					file_type = ".wav"
				
				print("loading file: " + file_path + file_type)
				sound_filepath = file_path + file_type
			
			total_sfx -= 1
		
		
		if randi_range(0, 1):
			var total_music = settings.total_music
			var rolled_music = randi_range(1, total_music)
			while total_music > 0:
				if rolled_music == total_music:
					var file_path = "res://Exponaut Components/Other/Game Modes/Meme Mode/Meme Mode/audio/music/" + str(total_music)
					var file_type : String
					if ResourceLoader.exists(file_path + ".mp3"):
						file_type = ".mp3"
					elif ResourceLoader.exists(file_path + ".wav"):
						file_type = ".wav"
					
					print("loading file: " + file_path + file_type)
					music_filepath = file_path + file_type
				
				total_music -= 1
		
		else:
			var total_music = settings.total_common_music
			var rolled_music = randi_range(1, total_music)
			while total_music > 0:
				if rolled_music == total_music:
					var file_path = "res://Exponaut Components/Other/Game Modes/Meme Mode/Meme Mode/audio/music/common/" + str(total_music)
					var file_type : String
					if ResourceLoader.exists(file_path + ".mp3"):
						file_type = ".mp3"
					elif ResourceLoader.exists(file_path + ".wav"):
						file_type = ".wav"
					
					print("loading COMMON file: " + file_path + file_type)
					music_filepath = file_path + file_type
				
				total_music -= 1
		
		
		$AudioStreamPlayer2D.stream = load(music_filepath)
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1)
		$AudioStreamPlayer2D.volume_db = randf_range(-10, 30)
		$AudioStreamPlayer2D.play()
		print("PLAYING MUSIC")
		
		if isBasicEmojiSpam:
			return
		
		var rolled_opacity = randi_range(0, 1)
		if rolled_opacity:
			opacity_fade_out = true
		else:
			opacity_fade_out = false
		
		if not is_video_quick:
			var rolled_scale = randi_range(0, 1)
			if rolled_scale:
				scale_down = true
			else:
				scale_down = false
		
		var rolled_rotates = randi_range(0, 3)
		if rolled_rotates == 3:
			rotates = true
		else:
			rotates = false
		
		var rolled_fall = randi_range(0, 2)
		if rolled_fall == 1 or rolled_fall == 2:
			fall_down = true
		else:
			fall_down = false
		
		z_index_value = randi_range(50, 200)
		
		vel_x = randi_range(-800, 800)
		vel_y = randi_range(-1000, 250)
		
		scale_x = randf_range(0.25, 1.25)
		scale_y = randf_range(0.25, 0.75)
		
		rotate_speed = randf_range(1, 15)
		
		var rolled_rotate_left = randi_range(0, 1)
		if rolled_rotate_left:
			rotate_left = true
		else:
			rotate_left = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	var image = meme_scene.instantiate()
	
	image.image_filepath = image_filepath
	
	if isBasicEmojiSpam:
		image.isBasicEmojiSpam = true
		image.fall_down = true
		image.scale_down = false
		image.position = position
		image.opacity_fade_out = false
		get_parent().add_child(image)
		return
	
	image.opacity_fade_out = opacity_fade_out
	image.scale_down = scale_down
	if scale_down:
		image.position = position + Vector2(randi_range(-200, 200), randi_range(-200, 200))
	else:
		image.position = position
	image.rotate_deg = rotate_deg
	image.scale_x = scale_x
	image.scale_y = scale_y
	image.vel_x = vel_x
	image.vel_y = vel_y
	image.z_index_value = z_index_value
	image.fall_down = fall_down
	image.rotate_speed = rotate_speed
	image.rotate_left = rotate_left
	image.anim_scale_loop = anim_scale_loop
	image.is_video = is_video
	image.is_video_quick = is_video_quick
	image.video_foreground = video_foreground
	
	if not randomize_all:
		image.is_single = true
	
	get_parent().add_child(image)
	
	if only_one or anim_scale_loop or is_video or is_video_quick:
		queue_free()
		print("REMOVED MUSIC")


func _on_timer_2_timeout():
	queue_free()


var sfx = preload("res://Exponaut Components/Other/Game Modes/Meme Mode/memeMode_sfx.tscn")

func _on_timer_3_timeout():
	if not randomize_all:
		return
	
	var x = randi_range(0, 3)
	if not x == 3:
		return
	
	var sound_effect = sfx.instantiate()
	sound_effect.stream = load(sound_filepath)
	sound_effect.pitch_scale = randf_range(0.8, 1.2)
	sound_effect.volume_db = randf_range(-30, 20)
	add_child(sound_effect)
	
	if sfx_only_one:
		$Timer3.queue_free()

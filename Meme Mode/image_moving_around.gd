extends Node2D

@onready var settings = $/root/example_rootScene/arabfunny_controller/Settings

var image_filepath = "res://Meme Mode/pictures/5.jpg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(randi_range(-500, 500), randi_range(-500, 500))
	
	random_image()
	$image.texture = load(image_filepath)
	
	$Timer.wait_time = randf_range(0.5, 12)
	$Timer.start()


var target_position = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	modulate.a = move_toward(modulate.a, 1, delta)

func random_image():
	var img_total = settings.total_pictures
	var rolled_img = randi_range(1, img_total)
	while img_total > 0:
		if rolled_img == img_total:
			var file_path = "res://Meme Mode/pictures/" + str(img_total)
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

func _on_timer_timeout() -> void:
	queue_free()

func _on_timer_2_timeout() -> void:
	target_position = Vector2(randi_range(-150, 150), randi_range(-150, 150))
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_position, 1)

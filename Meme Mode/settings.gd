extends Node2D

var main_rate : float = 1
var secondary_rate : float = 1
var major_greenscreen_rate : float = 1

@onready var label = $Label
@onready var label2 = $Label2
@onready var label3 = $Label3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("decrease"):
		if Input.is_action_pressed("spawn1"):
			main_rate *= 1.05
		elif Input.is_action_pressed("spawn2"):
			secondary_rate *= 1.05
		elif Input.is_action_pressed("spawn3"):
			major_greenscreen_rate *= 1.05
		else:
			main_rate *= 1.05
			secondary_rate *= 1.05
			major_greenscreen_rate *= 1.05
		
		main_rate = clamp(main_rate, 0.05, 10)
		secondary_rate = clamp(secondary_rate, 0.05, 10)
		major_greenscreen_rate = clamp(major_greenscreen_rate, 0.05, 10)
		
		label.text = "Main spawn rate: " + str(main_rate)
		label2.text = "Secondary spawn rate: " + str(secondary_rate)
		label3.text = "Major greenscreen spawn rate: " + str(major_greenscreen_rate)
	
		$AnimationPlayer.stop()
		$AnimationPlayer.play("fade_out")
	
	elif Input.is_action_pressed("increase"):
		if Input.is_action_pressed("spawn1"):
			main_rate *= 0.95
		elif Input.is_action_pressed("spawn2"):
			secondary_rate *= 0.95
		elif Input.is_action_pressed("spawn3"):
			major_greenscreen_rate *= 0.95
		else:
			main_rate *= 0.95
			secondary_rate *= 0.95
			major_greenscreen_rate *= 0.95
		
		main_rate = clamp(main_rate, 0.05, 10)
		secondary_rate = clamp(secondary_rate, 0.05, 10)
		major_greenscreen_rate = clamp(major_greenscreen_rate, 0.05, 10)
	
		label.text = "Main spawn rate: " + str(main_rate)
		label2.text = "Secondary spawn rate: " + str(secondary_rate)
		label3.text = "Major greenscreen spawn rate: " + str(major_greenscreen_rate)
	
		$AnimationPlayer.stop()
		$AnimationPlayer.play("fade_out")

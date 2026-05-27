extends CanvasLayer

@onready var player_main: Control = $player_main

@onready var animation_player: AnimationPlayer = $animation_ui

@onready var container_time: CenterContainer = $container_time
@onready var label_level_time: Label = %label_level_time


var active = false


func _ready() -> void:
	Globals.reassign_general()
	
	Globals.HUD_update_general.connect(update_general)
	
	animation_player.play("show")
	
	update_general()

func update_general():
	if Globals.gameState_levelSet_screen or Globals.gameState_start_screen:
		Globals.dm("Deleting the HUD (on Game State change).")
		queue_free()


func _on_animation_ui_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hide":
		Globals.dm("Deleting the HUD.")
		queue_free()

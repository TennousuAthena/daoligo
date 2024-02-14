extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * 600
	
	if Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		$Sddl.flip_h = false
	if !Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_right"):
		$Sddl.flip_h = true

	move_and_slide()


func _on_炫狗_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

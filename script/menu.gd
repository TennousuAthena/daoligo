extends Node2D

var sound = []
var tween

func _ready():
	sound = [$"冲刺sound", $"冲Sound", $"哇袄sound"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_冲刺_pressed():
	sound[0].play()
	await sound[0].finished
	for i in range(3):
		sound[1].play()
		await sound[1].finished
	$"哇袄".visible  = true
	sound[2].play()
	var tween = get_tree().create_tween()
	tween.tween_property($"哇袄", "scale", Vector2(20, 20), sound[2].stream.get_length()+0.1)
	tween.tween_callback($"哇袄".queue_free)
	await sound[2].finished
	get_tree().change_scene_to_file("res://daoliShoot.tscn")



func _on_嘟嘟嘟_pressed():
	get_tree().change_scene_to_file("res://dududu.tscn")

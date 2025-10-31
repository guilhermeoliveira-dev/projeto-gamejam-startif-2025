extends Node2D

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://cenas/cutscenes/cutscene_1.tscn")

func _on_quit_btn_pressed():
	get_tree().quit()

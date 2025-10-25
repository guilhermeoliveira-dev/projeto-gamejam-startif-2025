extends CharacterBody2D

func _process(_delta):
	
	velocity.x = 100
	
	move_and_slide()

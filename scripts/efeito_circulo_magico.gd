extends Node2D

@onready var sprite: AnimatedSprite2D = %Sprite

func rodar_animacao():
	
	sprite.frame = 0
	sprite.play()

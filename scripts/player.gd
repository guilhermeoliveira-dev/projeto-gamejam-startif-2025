extends CharacterBody2D

@export var velocidade: float = 250.0
@export var altura_pulo: float = 400.0
@export var gravidade: float = 200.0




func _physics_process(delta):
	var direcao = Input.get_axis("mover_esquerda", "mover_direita")

	velocity.x = direcao * velocidade
	
	var no_chao: bool = is_on_floor()
	
	if not no_chao:
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("pular") and no_chao:

		velocity.y = -altura_pulo



	move_and_slide()

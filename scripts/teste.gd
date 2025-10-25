extends CharacterBody2D

@export var velocidade: float = 250.0
@export var altura_pulo: float = 400.0
@export var duracao_pulo: float = 0.6

var pulando: bool = false
var tempo_pulo: float = 0.0
var pos_inicial_y: float = 0.0

func _physics_process(delta):
	var direcao = 0
	if Input.is_action_pressed("ui_right"):
		direcao += 1
	elif Input.is_action_pressed("ui_left"):
		direcao -= 1

	velocity.x = direcao * velocidade
	
	if not is_on_floor():
		velocity.y = 30

	if Input.is_action_just_pressed("ui_up") and not pulando:
		pulando = true
		tempo_pulo = 0.0
		pos_inicial_y = global_position.y

	if pulando:
		tempo_pulo += delta
		var t = tempo_pulo / duracao_pulo

		if t < 0.5:
			global_position.y = pos_inicial_y - (altura_pulo * (t * 2))
		elif t < 1.0:
			global_position.y = pos_inicial_y - (altura_pulo * (2 - t * 2))
		else:
			pulando = false
			global_position.y = pos_inicial_y

	move_and_slide()

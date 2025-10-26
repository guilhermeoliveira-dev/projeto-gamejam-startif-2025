@tool
extends CharacterBody2D
class_name Player

@export_group("fisica")
@export var velocidade: float = 250.0
@export var altura_pulo: float = 400.0
@export var gravidade: float = 200.0

@export_group("gameplay")
signal recebeu_dano(vida_atual: float)
signal player_morreu()
@export var vida_maxima: float = 30
@onready var vida: float = vida_maxima:
	set(valor):
		vida = valor
		recebeu_dano.emit(vida)
		if valor <= 0:
			player_morreu.emit()
		



@export var projetil_cena: PackedScene
@export var tipo_projetil: TipoProjetil
@export var cooldown_projetil: float = 3:
	set(valor):
		cooldown_projetil = valor
		cooldown_projetil_timer.wait_time = valor
@onready var cooldown_projetil_timer: Timer = %CooldownProjetil
@onready var projeteis_holder: Node2D = get_tree().current_scene.find_child("Projeteis")


@onready var sprites: AnimatedSprite2D = %Sprite


var ultima_direcao: float = 1
var direcao: float = 0

func _physics_process(delta):
	
	
	if Engine.is_editor_hint():
		return
	
	direcao = Input.get_axis("mover_esquerda", "mover_direita")
	if direcao != 0:
		ultima_direcao = direcao
	
	velocity.x = direcao * velocidade
	
	var no_chao: bool = is_on_floor()
	
	if not no_chao:
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("pular") and no_chao:
		velocity.y = -altura_pulo
	
	if Input.is_action_just_pressed("usar_magia"):
		invocar_projetil()
	
	move_and_slide()

func _process(_delta):
	
	if Engine.is_editor_hint():
		return
	
	
	if is_on_floor():
		
		if direcao != 0:
			rodar_animacao("walk")
		else:
			rodar_animacao("idle")
			
		
	#else:
		## Animacoes no ar (pulando e caindo)
		#if velocity.y > 0:
			#rodar_animacao("fall")
		#elif velocity.y < 0:
			#rodar_animacao("jump")
	
	sprites.scale.x = ultima_direcao
	

func rodar_animacao(animacao: String):
	if sprites.animation != animacao:
		sprites.play(animacao)

func receber_dano(dano: float):
	
	vida -= dano
	#recebeu_dano.emit(vida)

func invocar_projetil():
	
	if cooldown_projetil_timer.time_left == 0:
		var projetil_instancia: ProjetilNode = projetil_cena.instantiate()
		
		projeteis_holder.add_child(projetil_instancia)
		
		projetil_instancia.tipo_projetil = tipo_projetil
		projetil_instancia.direcao = Vector2(ultima_direcao, 0)
		projetil_instancia.position = position + Vector2(10, 0) * ultima_direcao
		
		cooldown_projetil_timer.start()
	

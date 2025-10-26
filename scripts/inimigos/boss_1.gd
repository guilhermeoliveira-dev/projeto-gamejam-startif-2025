extends CharacterBody2D

@export var vida_maxima: float = 10
@onready var vida: float = vida_maxima

@export var velocidade_movimento: float = 60
@export var distancia_descongelar: float = 400
@export var dano_causado: float = 10

@onready var sprites: AnimatedSprite2D = %Sprites
@onready var collision: CollisionShape2D = %Collision 
@onready var hurtbox: Area2D = %HurtBox
@onready var andando_timer: Timer = %Andando
@onready var cast_player: RayCast2D = %ApontaPlayer
@onready var cooldown_ataque: Timer = %CooldownAtaque
@onready var projeteis_holder: Node2D = get_tree().current_scene.find_child("Projeteis")

@export var distancia_ataque: float = 500

@export var projetil_cena: PackedScene
@export var tipo_projetil: TipoProjetil

var direcao: float = -1
var congelado: bool = true

var faccao: String = "inimigo"

static var player: Player

func _ready():
	
	if player == null:
		player = get_tree().current_scene.find_child("Player")
	
	andando_timer.timeout.connect(mudar_direcao)
	hurtbox.body_entered.connect(colidir_body)

func _physics_process(delta):
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if congelado:
		if player.position.distance_to(position) < distancia_descongelar:
			congelado = false
			direcao = 1
			mudar_direcao()
			if randi_range(0,1) == 1:
				mudar_direcao()
		else:
			return
	
	if cooldown_ataque.is_stopped():
		atacar()
		
	
	move_and_slide()
	
	if is_on_wall():
		mudar_direcao()
	

func atacar():
	
	var direcao_player = to_local(player.position) - cast_player.position 
	direcao_player = direcao_player.normalized()
	
	cast_player.target_position = direcao_player * distancia_ataque
	
	#print(cast_player.get_collider())
	
	if cast_player.get_collider() != null:
		cooldown_ataque.start()
		
		var projetil_instancia: ProjetilNode = projetil_cena.instantiate()
		
		projeteis_holder.add_child(projetil_instancia)
		#projetil_instancia._ready()
		
		projetil_instancia.tipo_projetil = tipo_projetil
		projetil_instancia.direcao = direcao_player
		projetil_instancia.position = position + Vector2(80, 0) * direcao_player
		projetil_instancia.grupo_faccao = "inimigo"
		

func colidir_body(body: Node):
	
	if not body.is_in_group("recebe_dano"):
		return
	
	if not body.is_in_group(faccao):
		body.receber_dano(dano_causado)
	

func receber_dano(dano: float):
	
	vida -= dano
	if vida <= 0:
		congelado = true
		#collision.set_deferred("disabled", true)
		process_mode = Node.PROCESS_MODE_DISABLED
		sprites.play("death")
		sprites.animation_finished.connect(remover)
	#recebeu_dano.emit(vida)


func remover():
	queue_free()
	SceneController.changeSceneTo("res://cenas/cutscenes/cutscene_3.tscn")

func mudar_direcao():
	
	direcao *= -1
	
	velocity.x = direcao * velocidade_movimento
	
	andando_timer.start(randf_range(3, 6))

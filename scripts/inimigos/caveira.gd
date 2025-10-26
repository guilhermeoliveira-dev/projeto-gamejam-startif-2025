extends CharacterBody2D

@export var vida_maxima: float = 10
@onready var vida: float = vida_maxima

@export var velocidade_movimento: float = 60
@export var distancia_descongelar: float = 400

@onready var andando_timer: Timer = %Andando

@export var dano_causado: float = 10

@onready var sprites: AnimatedSprite2D = %Sprites

@onready var collision: CollisionShape2D = %Collision 

@onready var hurtbox: Area2D = %HurtBox

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
	
	
	
	move_and_slide()
	
	if is_on_wall():
		mudar_direcao()
	



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

func mudar_direcao():
	
	direcao *= -1
	
	velocity.x = direcao * velocidade_movimento
	
	andando_timer.start(randf_range(3, 6))

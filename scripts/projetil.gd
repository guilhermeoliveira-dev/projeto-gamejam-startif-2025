extends CharacterBody2D
class_name ProjetilNode

@onready var sprites: AnimatedSprite2D
@onready var hurtbox: Area2D

var tipo_projetil: TipoProjetil:
	set(valor):
		tipo_projetil = valor
		if is_node_ready():
			velocidade = valor.VELOCIDADE
			sprites.sprite_frames = valor.ANIMACAO
			sprites.play("default")


var velocidade: float = 200:
	set(valor):
		velocidade = valor
		if is_node_ready():
			velocity = direcao * velocidade

var direcao: Vector2:
	set(valor):
		direcao = valor.normalized()
		if is_node_ready():
			velocity = direcao * velocidade
			rotation = velocity.angle()

var grupo_faccao: String:
	set(valor):
		grupo_faccao = valor
		add_to_group(valor)

func _ready():
	
	sprites = find_child("Sprite")
	hurtbox = find_child("HurtBox")
	
	if not hurtbox.body_entered.is_connected(colidir_body):
		hurtbox.body_entered.connect(colidir_body)
	

func _physics_process(_delta):
	
	move_and_slide()
	

func colidir_body(body: Node):
	
	if body.is_in_group("recebe_dano"):
		
		if not body.is_in_group(grupo_faccao):
			
			body.receber_dano(tipo_projetil.DANO)
			remover()
	
	else:
		remover()

func remover():
	self.queue_free()

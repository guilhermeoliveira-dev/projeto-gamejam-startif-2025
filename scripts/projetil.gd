extends CharacterBody2D
class_name ProjetilNode

@onready var sprites: AnimatedSprite2D = %Sprite

@export var tipo_projetil: TipoProjetil:
	set(valor):
		velocidade = valor.VELOCIDADE
		sprites.sprite_frames = valor.ANIMACAO
		sprites.play("default")



var velocidade: float = 200:
	set(valor):
		velocity = direcao * velocidade

var direcao: Vector2:
	set(valor):
		direcao = valor.normalized()
		velocity = direcao * velocidade
		rotation = velocity.angle()

var grupo_faccao: String:
	set(valor):
		grupo_faccao = valor
		add_to_group(valor)

func _physics_process(_delta):
	
	move_and_slide()
	

func colidir_body(body: Node):
	
	if body.is_in_group("recebe_dano"):
		
		if not body.is_in_group(grupo_faccao):
			
			body.receber_dano()
			remover()
	

func remover():
	self.queue_free()

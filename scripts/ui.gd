extends CanvasLayer

@onready var barra_vida: ProgressBar = %BarraVida

func _ready():
	
	var player: Player = get_tree().current_scene.find_child("Player")
	
	player.recebeu_dano.connect(atualizar_barra_vida)
	
	atualizar_barra_vida_maxima(player.vida_maxima)
	atualizar_barra_vida(player.vida)
	

func atualizar_barra_vida_maxima(vida_maxima):
	
	barra_vida.max_value = vida_maxima
	

func atualizar_barra_vida(vida_atual):
	
	barra_vida.value = vida_atual
	

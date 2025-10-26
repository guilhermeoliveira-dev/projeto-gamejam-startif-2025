@tool
extends Cutscene

#@onready var animacao: AnimationPlayer = %Animacao
#
#@onready var icone_continuar: TextureButton = %IconeContinuarInicial
#
#@onready var vozes_player: AudioStreamPlayer = %Vozes
#@onready var musica_player: AudioStreamPlayer = %Musica
#
#
#
#
#signal dialogo_atual_alterado
#var dialogo_atual: DialogoResource:
	#set(valor):
		#dialogo_atual = valor
		#dialogo_atual_alterado.emit()

func _input(event):
	
	if animacao == null:
		return
	
	if not animacao.active:
		
		if event.is_action_pressed("ui_accept"):
			
			retomar_animacao()
			
			#if proximo_dialogo != -1:
				

func _ready():
	#icone_continuar.pressed.connect(retomar_animacao)
	pass
	

func pausar_animacao():
	#print("pausei")
	animacao.active = false
	

func retomar_animacao():
	#print("voltei")
	animacao.active = true

func trocar_dialogo(dialogo: DialogoResource):
	dialogo_atual = dialogo
	

func encerrar_cena():
	
	#musica_player.stream.
	#SceneController.changeSceneTo("res://cenas/fases/fase2.tscn")
	pass
	

#@export var voz_1: AudioStreamOggVorbis
#@export var voz_2: AudioStreamOggVorbis
#@export var voz_3: AudioStreamOggVorbis


func vozes_1():
	vozes_player.stream = voz_1
	vozes_player.play()
	
func vozes_2():
	vozes_player.stream = voz_2
	vozes_player.play()
func vozes_3():
	vozes_player.stream = voz_3
	vozes_player.play()

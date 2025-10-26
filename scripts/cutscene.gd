@tool
extends Node2D
class_name Cutscene

@onready var animacao: AnimationPlayer = %Animacao

@onready var icone_continuar: TextureButton = %IconeContinuarInicial

signal dialogo_atual_alterado
var dialogo_atual: DialogoResource:
	set(valor):
		dialogo_atual = valor
		dialogo_atual_alterado.emit()

func _input(event):
	
	if animacao == null:
		return
	
	if not animacao.active:
		
		if event.is_action_pressed("ui_accept"):
			
			retomar_animacao()
			
			#if proximo_dialogo != -1:
				

func _ready():
	icone_continuar.pressed.connect(retomar_animacao)
	

func pausar_animacao():
	#print("pausei")
	animacao.active = false
	

func retomar_animacao():
	#print("voltei")
	animacao.active = true

func trocar_dialogo(dialogo: DialogoResource):
	dialogo_atual = dialogo
	

func encerrar_cena():
	
	SceneController.changeSceneTo("res://cenas/fases/fase1.tscn")
	

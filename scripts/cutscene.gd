@tool
extends Node2D
class_name Cutscene

@onready var animacao: AnimationPlayer = %Animacao

signal dialogo_atual_alterado
var dialogo_atual: DialogoResource:
	set(valor):
		dialogo_atual = valor
		dialogo_atual_alterado.emit()



func _input(event):
	
	if not animacao.active:
		
		if event.is_action_pressed("ui_accept"):
			
			retomar_animacao()
			
			
			#if proximo_dialogo != -1:
				

func pausar_animacao():
	print("pausei")
	animacao.active = false
	

func retomar_animacao():
	print("voltei")
	animacao.active = true


func trocar_dialogo(dialogo: DialogoResource):
	dialogo_atual = dialogo
	

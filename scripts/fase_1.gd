extends Node2D

#@onready var tela_dialogo: CanvasLayer = %Dialogo

@onready var final_fase: Area2D = %FinalFase


func _ready():
	
	final_fase.body_entered.connect(encerrar_cena)


func encerrar_cena(_body):
	
	#print("oi")
	if _body.is_in_group("original_player"):
	#musica_player.stream.
		SceneController.changeSceneTo("res://cenas/cutscenes/cutscene_2.tscn")

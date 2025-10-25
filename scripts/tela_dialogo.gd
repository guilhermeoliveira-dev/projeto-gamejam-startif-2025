extends CanvasLayer

@onready var retrato_node: TextureRect = %RetratoDialogo
@onready var nome_node: Label = %Nome
@onready var dialogo_nome: Label = %Dialogo
@onready var icone_continuar: TextureButton = %IconeContinuarDialogo

var cutscene: Cutscene

@export var retrato_padrao: Texture

func _ready():
	
	cutscene = find_parent("Cutscene*")
	
	cutscene.dialogo_atual_alterado.connect(atualizar_dialogo)
	icone_continuar.pressed.connect(cutscene.retomar_animacao)
	

func atualizar_dialogo():
	
	visible = true
	
	var dialogo_resource: DialogoResource = cutscene.dialogo_atual
	
	
	retrato_node.texture = dialogo_resource.foto if dialogo_resource != null else retrato_padrao
	nome_node.text = dialogo_resource.nome
	dialogo_nome.text = dialogo_resource.dialogo
	
#
#func icone_dialogo_aparecer():
	#icone_continuar.visible = true
#
#func icone_dialogo_desaparecer():
	#icone_continuar.visible = false

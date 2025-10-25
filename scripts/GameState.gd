extends Node




#signal dialogo_completo_atual_alterado
#var dialogo_completo_atual: DialogoCompletoResource:
	#set(valor):
		#dialogo_completo_atual = valor
		#dialogo_completo_atual_alterado.emit()


#signal dialogo_ativo_alterado
#var dialogo_ativo: bool = false:
	#set(valor):
		#dialogo_ativo = valor
		#dialogo_ativo_alterado.emit()


#func proximo_dialogo() -> int:
	#
	#var proximo_dialogo_valor = dialogo_atual + 1
	#
	#if dialogo_atual == -1:
		#return -1
	#elif proximo_dialogo_valor < dialogo_completo_atual.linhas_dialogo.size():
		#return proximo_dialogo_valor
	#
	#return 0

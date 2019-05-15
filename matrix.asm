####################################################################
# Disciplina: Arquitetura e Organização de Computadores
# Atividade: Avaliação 01 - Programação em Linguagem de Montagem
# Programa 01
# Grupo: - Douglas Martins
# - Henrique Backes
#
####################################################################



	.data
Matrix_A: 	          .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # Declaração da Matrix A (max matrix_A[4][4])
Matrix_B: 	          .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # Declaração da Matrix B (max matrix_B[4][4])
Matrix_C: 	          .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # Declaração da Matrix C (max matrix_C[4][4])
MsgEnterSizeColumn:       .asciiz "\nEntre com o tamanho da coluna (máx. = 4): "
MsgEnterSizeRow:       	  .asciiz "\nEntre com o tamanho da linha (máx. = 4): "
MsgInputValuesBegin:   	  .asciiz "\nMatrix_"
MsgInputValuesMiddle:     .asciiz "["
MsgInputValuesFinal:      .asciiz "] = "
MsgWrongValue:      	  .asciiz "\nValor inv�lido" 

	.text
j	main
	
Loop_Matrix_Size:
Msg_Size:	
	# PRINT READ SIZE MSG
	li   $v0, 4			# Chamada 4 (syscall code para imprimit uma String)
	la   $a0, MsgEnterSizeColumn		# MsgEnterSize
	syscall				# Executar a chamada do syscall
	
	# READ INT (SIZE)
	li   $v0, 5			# Chamada 5 (syscall code para ler um int)
	syscall				# Executar a chamada do syscall
	add  $t1, $v0, $0		# Salva o valor condito em $v0, em $t1 (Numero lido)
	
	# CONDITION (to stay or exit the Loop_Matrix_Size)
	slti $t0, $t1, 1		# if (size < 1) $t0 = 1 else $t0 = 0
	bgt  $t1, 4 Incorrect_Size	# if (size > 4) goto Incorrect_Size
	#beq  $t0, $zero, Loop_Read	# if ($t0 == 0) goto Loop_Read
	beq  $t0, 1, Incorrect_Size	# if ($t0 == 1) goto Incorrect_Size
	
jr	$ra			# goto Loop_Array_Size

Incorrect_Size:
	# PRINT WRONG SIZE NUMBER MSG
	li  $v0, 4			# Chamada 4 (syscall code para imprimir uma String)
	la  $a0, MsgWrongValue		# MsgWrongValue
	syscall				# Executar a chamada do syscall
j	Msg_Size			# goto Msg_Size
#---------- MSG_SIZE ----------#

main:
	jal Loop_Matrix_Size
	
	add  $s3, $t1, 0 		# Coluna_A = 0 no registrador $s3
	
	jal Loop_Matrix_Size
	
	addi $s4, $t1, 0		# Linha_A = 0 no registrador $s4
	
	jal Loop_Matrix_Size
	
	addi $s5, $t1, 0		# Coluna_B = 0 no registrador $s3
	
	jal Loop_Matrix_Size
	
	addi $s6, $t1, 0		# Linha_B = 0 no registrador $s4
	
	# MAIN VARIABLES
	la   $s0, Matrix_A		# Carrega o Matrix_A[] no registrador $s0
	la   $s1, Matrix_B		# Carrega o Matrix_B[] no registrador $s1
	la   $s2, Matrix_C		# Carrega o Matrix_C[] no registrador $s2


	#addi $s7, $zero, 0		# i = 0 no registrador $s5
	
	nop


	

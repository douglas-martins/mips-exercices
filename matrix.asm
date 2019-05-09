####################################################################
# Disciplina: Arquitetura e Organização de Computadores
# Atividade: Avaliação 01 - Programação em Linguagem de Montagem
# Programa 01
# Grupo: - Douglas Martins
# - Henrique Backes
#
####################################################################



	.data
Matrix_A 	          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # Declaração da Matrix A (max matrix_A[4][4])
Matrix_B 	          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # Declaração da Matrix B (max matrix_B[4][4])
Matrix_C 	          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # Declaração da Matrix C (max matrix_C[4][4])
MsgEnterSizeColumn:       .asciiz "\nEntre com o tamanho da coluna (máx. = 4): "
MsgEnterSizeRow:       	  .asciiz "\nEntre com o tamanho da linha (máx. = 4): "
MsgWrongValue:      	  .asciiz "\nValor inválido."
MsgInputValuesA:    	  .asciiz "\nMatrix_A["
MsgInputValuesB:          .asciiz "\nMatrix_B["
MsgInputValuesC:          .asciiz "\nMatrix_C["
MsgInputValuesFinal:      .asciiz "] = " 

	.text
main:
	# MAIN VARIABLES
	la   $s0, Matrix_A		# Carrega o Matrix_A[] no registrador $s0
	la   $s1, Matrix_B		# Carrega o Matrix_B[] no registrador $s1
	la   $s2, Matrix_A		# Carrega o Matrix_C[] no registrador $s2
	addi $s3, $zero, 0		# Coluna_A = 0 no registrador $s3
	addi $s4, $zero, 0		# Linha_A = 0 no registrador $s4
	addi $s5, $zero, 0		# Coluna_B = 0 no registrador $s3
	addi $s6, $zero, 0		# Linha_B = 0 no registrador $s4
	addi $s7, $zero, 0		# i = 0 no registrador $s5
	
Loop_Matrix_Size:
Msg_Size:	
	# PRINT READ SIZE MSG
	li   $v0, 4			# Chamada 4 (syscall code para imprimit uma String)
	la   $a0, MsgEnterSize		# MsgEnterSize
	syscall				# Executar a chamada do syscall
	
	# READ INT (SIZE)
	li   $v0, 5			# Chamada 5 (syscall code para ler um int)
	syscall				# Executar a chamada do syscall
	add  $s1, $v0, $0		# Salva o valor condito em $v0, em $s1 (Numero lido)
	
	# CONDITION (to stay or exit the Loop_Array_Size)
	slti $t0, $s1, 1		# if (size < 1) $t0 = 1 else $t0 = 0
	bgt  $s1, 4 Incorrect_Size	# if (size > 4) goto Incorrect_Size
	beq  $t0, $zero, Loop_Read	# if ($t0 == 0) goto Loop_Read
	beq  $t0, 1, Incorrect_Size	# if ($t0 == 1) goto Incorrect_Size
	
j	Loop_Matrix_Size			# goto Loop_Array_Size

Incorrect_Size:
	# PRINT WRONG SIZE NUMBER MSG
	li  $v0, 4			# Chamada 4 (syscall code para imprimir uma String)
	la  $a0, MsgWrongValue		# MsgWrongValue
	syscall				# Executar a chamada do syscall
j	Msg_Size			# goto Msg_Size

Loop_Read:
	# CONDITION 
	slt  $t0, $s2, $s1              # if (i < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Prepare_Array  # if ($t0 == 0) goto Prepare_Array
        
        # DESLOCAMENTO
        add  $t1, $s2, $s2         	# $t1 = 2.i  
      	add  $t1, $t1, $t1         	# $t1 = 4.i
      	add  $t1, $t1, $s0         	# $t1 = end.base + 4.i (deslocamento) = end. de A[i]
      	
      	# PRINT MsgInputValues1
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValues1       # MsgInputValues1
      	syscall
      	
      	# PRINT I
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $s2 	  	# $s2 = index of array (i)
      	syscall
      	
      	# PRINT MsgInputValues2
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValues2       # MsgInputValues2
      	syscall  
      	
      	# READ INT
      	li   $v0, 5                	# chamada 5 
      	syscall                    
      	add  $s3, $v0, $0          	# salva $v0 em $s3
	
	# STORE $s4 IN A[i]
      	sw   $s3, 0($t1)            	# salva $s4 no array A[i] 
     
     	# ADDING INDEX LOOP ++
        addi $s2, $s2, 1          	# i++


j	Loop_Read			# goto Loop_Read	
	
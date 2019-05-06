####################################################################
# Disciplina: Arquitetura e Organização de Computadores
# Atividade: Avaliação 01 -	 Programação em Linguagem de Montagem
# Programa 01
# Grupo: - Douglas Martins
#
####################################################################


	.data 				 # segmento de dados
Vetor_A:            .word 0 0 0 0 0 0 0 0  # defincao do array A[]. Coloca os valores no array A[]
MsgEnterSize:       .asciiz "\nEntre com o tamanho do vetor (máx. = 8): "
MsgWrongValue:      .asciiz "\nValor inválido."
MsgInputValues1:    .asciiz "\nVetor_A["
MsgInputValues2:    .asciiz "] = "
MsgBiggerValue1:    .asciiz "\nO maior elemento do vetor é o "
MsgBiggerValue2:    .asciiz " e o seu valor é "

	.text				# Segmento de codigo
main:
	# MAIN VARIABLES
	la   $s0, Vetor_A		# Carrega o Vetor_A[] no registrador $s0
	addi $s1, $zero, 0		# size = 0 no registrador $s1
	addi $s2, $zero, 0		# i = 0 no registrador $s2
	addi $s6, $zero, 0		# biggerNumberIndex = 0

Loop_Array_Size:
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
	bgt  $s1, 8 Incorrect_Size	# if (size > 8) goto Incorrect_Size
	beq  $t0, $zero, Loop_Read	# if ($t0 == 0) goto Loop_Read
	beq  $t0, 1, Incorrect_Size	# if ($t0 == 1) goto Incorrect_Size

j	Loop_Array_Size			# goto Loop_Array_Size

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

Prepare_Array:
	# PREPARE TO FIND BIGGER NUMBER (i = 0, $s4 = first element of array Vetor_A[0])
	addi $s2, $zero, 1		# i = 1
	lw   $s4, 0($s0)            	# $s4 = A[0]
	addi $s6, $zero, 0		# $s6 = 0 (index of bigger number)
j	Loop_Find_Bigger_Element

Loop_Find_Bigger_Element:
	# CONDITION
	slt  $t0, $s2, $s1              # if (i < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Print_Result   # if ($t0 == 0) goto Print_Result

        # DESLOCAMENTO
        add  $t1, $s2, $s2         	# $t1 = 2.i
      	add  $t1, $t1, $t1         	# $t1 = 4.i
      	add  $t1, $t1, $s0         	# $t1 = end.base + 4.i (deslocamento) = end. de A[i]

      	# GETTING NEXT ELEMENT ON ARRAY
      	lw   $s5, 0($t1)		# $s5 = A[i]

	# CONDITION (TO FIND BIGGER NUMBER)
	bgt  $s5, $s4 Change_Number	# if (Vetor_A[i] > biggerNumber) goto Change_Number

	# ADDING INDEX LOOP ++
        addi $s2, $s2, 1          	# i++

j	Loop_Find_Bigger_Element	# goto Loop_Find_Bigger_Element

Change_Number:
	move $s4, $s5			# $s4 = $s5 (changing bigger number value)
	move $s6, $s2 			# $s6 = $s2 (changing bigger number index of Vetor_A)
j	Loop_Find_Bigger_Element	# goto Loop_Find_Bigger_Element

Print_Result:
	# PRINT MsgBiggerValue1
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgBiggerValue1       # MsgBiggerValue1
      	syscall

      	# PRINT I
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $s6 	  	# print $s6 (i)
      	syscall


      	# PRINT MsgBiggerValue2
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgBiggerValue2       # MsgBiggerValue2
      	syscall

      	# PRINT BIGGER VALUE
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $s4 	  	# print $s4 (biggerNumber)
      	syscall


j	Exit				# goto Exit

Exit:	nop

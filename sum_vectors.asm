####################################################################
# Disciplina: Arquitetura e Organização de Computadores
# Atividade: Avaliação 01 - Programação em Linguagem de Montagem
# Programa 02
# Grupo: - Douglas Martins
#
####################################################################

	.data				   # segmento de dados
Vetor_A:            .word 0 0 0 0 0 0 0 0  # defincao do array A[]. Coloca os valores no array A[]
Vetor_B:            .word 0 0 0 0 0 0 0 0  # defincao do array B[]. Coloca os valores no array B[]
Vetor_C:            .word 0 0 0 0 0 0 0 0  # defincao do array C[]. Coloca os valores no array C[]
MsgEnterSize:       .asciiz "\nEntre com o tamanho do vetor (máx. = 8): "
MsgWrongValue:      .asciiz "\nValor inválido."
MsgInputValuesA:    .asciiz "\nVetor_A["
MsgInputValuesB:    .asciiz "\nVetor_B["
MsgInputValuesC:    .asciiz "\nVetor_C["
MsgInputValuesFinal:    .asciiz "] = "

	.text
main:
	# MAIN VARIABLES
	la   $s0, Vetor_A		# Carrega o Vetor_A[] no registrador $s0
	la   $s1, Vetor_B		# Carrega o Vetor_B[] no registrador $s1
	la   $s2, Vetor_C		# Carrega o Vetor_C[] no registrador $s2
	addi $s3, $zero, 0		# size = 0 no registrador $s3
	addi $s4, $zero, 0		# i = 0 no registrador $s4

Loop_Array_Size:
Msg_Size:
	# PRINT READ SIZE MSG
	li   $v0, 4			# Chamada 4 (syscall code para imprimit uma String)
	la   $a0, MsgEnterSize		# MsgEnterSize
	syscall				# Executar a chamada do syscall

	# READ INT (SIZE)
	li   $v0, 5			# Chamada 5 (syscall code para ler um int)
	syscall				# Executar a chamada do syscall
	add  $s3, $v0, $0		# Salva o valor condito em $v0, em $s3 (Numero lido)

	# CONDITION (to stay or exit the Loop_Array_Size)
	slti $t0, $s3, 1		# if (size < 1) $t0 = 1 else $t0 = 0
	bgt  $s3, 8 Incorrect_Size	# if (size > 8) goto Incorrect_Size
	beq  $t0, $zero, Loop_Read_Vetor_A	# if ($t0 == 0) goto Loop_Read_Vetor_A
	beq  $t0, 1, Incorrect_Size	# if ($t0 == 1) goto Incorrect_Size

j	Loop_Array_Size			# goto Loop_Array_Size

Incorrect_Size:
	# PRINT WRONG SIZE NUMBER MSG
	li  $v0, 4			# Chamada 4 (syscall code para imprimir uma String)
	la  $a0, MsgWrongValue		# MsgWrongValue
	syscall				# Executar a chamada do syscall
j	Msg_Size			# goto Msg_Size

Loop_Read_Vetor_A:
	# CONDITION
	slt  $t0, $s4, $s3              # if (i < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Prepare_Array  # if ($t0 == 0) goto Prepare_Array

        # DESLOCAMENTO
        add  $t1, $s4, $s4         	# $t1 = 2.i
      	add  $t1, $t1, $t1         	# $t1 = 4.i
      	add  $t1, $t1, $s0         	# $t1 = end.base + 4.i (deslocamento) = end. de A[i]

      	# PRINT MsgInputValuesA
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesA       # MsgInputValuesA
      	syscall

      	# PRINT I
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $s4 	  	# $s4 = index of array (i)
      	syscall

      	# PRINT MsgInputValuesFinal
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesFinal   # MsgInputValuesFinal
      	syscall

      	# READ INT
      	li   $v0, 5                	# chamada 5
      	syscall
      	add  $s5, $v0, $0          	# salva $v0 em $s5

	# STORE $s4 IN A[i]
      	sw   $s5, 0($t1)            	# salva $s5 no array A[i]

     	# ADDING INDEX LOOP ++
        addi $s4, $s4, 1          	# i++


j	Loop_Read_Vetor_A		# goto Loop_Read_Vetor_A

Prepare_Array:
	# PREPARE TO NEXT ARRAY REDAD
	addi $s4, $zero, 0		# i = 0
j	Loop_Read_Vetor_B		# goto Loop_Read_Vetor_B

Loop_Read_Vetor_B:
	# CONDITION
	slt  $t0, $s4, $s3              # if (i < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Prepare_Array_Set_C  # if ($t0 == 0) goto Prepare_Array_Set_C

        # DESLOCAMENTO
        add  $t1, $s4, $s4         	# $t1 = 2.i
      	add  $t1, $t1, $t1         	# $t1 = 4.i
      	add  $t1, $t1, $s1         	# $t1 = end.base + 4.i (deslocamento) = end. de A[i]

      	# PRINT MsgInputValuesB
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesB       # MsgInputValuesB
      	syscall

      	# PRINT I
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $s4 	  	# $s4 = index of array (i)
      	syscall

      	# PRINT MsgInputValuesFinal
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesFinal   # MsgInputValuesFinal
      	syscall

      	# READ INT
      	li   $v0, 5                	# chamada 5
      	syscall
      	add  $s5, $v0, $0          	# salva $v0 em $s5

	# STORE $s5 IN B[i]
      	sw   $s5, 0($t1)            	# salva $s5 no array B[i]

     	# ADDING INDEX LOOP ++
        addi $s4, $s4, 1          	# i++

j	Loop_Read_Vetor_B		# goto Loop_Read_Vetor_B

Prepare_Array_Set_C:
	# PREPARE TO NEXT ARRAY REDAD
	addi $s4, $zero, 0		# i = 0
j	Loop_Set_Vetor_C		# goto Loop_Set_Vetor_C

Loop_Set_Vetor_C:
	# CONDITION
	slt  $t0, $s4, $s3              # if (i < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Prepare_Array_Print  # if ($t0 == 0) goto Prepare_Array_Print

        # DESLOCAMENTO VETOR_A
        add  $t1, $s4, $s4         	# $t1 = 2.i
      	add  $t1, $t1, $t1         	# $t1 = 4.i
      	add  $t1, $t1, $s0         	# $t1 = end.base + 4.i (deslocamento) = end. de A[i]

      	# DESLOCAMENTO VETOR_B
        add  $t2, $s4, $s4         	# $t2 = 2.i
      	add  $t2, $t2, $t2         	# $t2 = 4.i
      	add  $t2, $t2, $s1         	# $t2 = end.base + 4.i (deslocamento) = end. de A[i]

      	# DESLOCAMENTO VETOR_C
        add  $t3, $s4, $s4         	# $t3 = 2.i
      	add  $t3, $t3, $t3         	# $t3 = 4.i
      	add  $t3, $t3, $s2         	# $t3 = end.base + 4.i (deslocamento) = end. de A[i]

      	# LOAD VETOR_A[i]
      	lw   $s5, 0($t1)		# $s5 = Vetor_A[i]

      	# LOAD VETOR_B[i]
      	lw   $s6, 0($t2)		# $s6 = Vetor_B[i]

      	# SUM VECTORS VALUES
      	add  $s7, $s5, $s6		# $s7 = $s5 + $s6

      	# STORE $s7 IN C[i]
      	sw   $s7, 0($t3)            	# salva $s5 no array A[i]

      	# ADDING INDEX LOOP ++
        addi $s4, $s4, 1          	# i++

j	Loop_Set_Vetor_C		# goto Loop_Set_Vetor_C

Prepare_Array_Print:
	# PREPARE TO NEXT ARRAY REDAD
	addi $s4, $zero, 0		# i = 0
j	Print_Vetor_C			# goto Print_Vetor_C


Print_Vetor_C:
	# CONDITION
	slt  $t0, $s4, $s3       	# if (i < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Exit    	# if ($t0 == 0) goto Exit

        # DESLOCAMENTO
        add  $t1, $s4, $s4         	# $t1 = 2.j
      	add  $t1, $t1, $t1         	# $t1 = 4.j
      	add  $t1, $t1, $s2         	# $t1 = end.base + 4.i (deslocamento) = end. de A[i]

        # PRINT MsgInputValuesC
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesC   	# MsgInputValuesC
      	syscall

      	# PRINT I
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $s4 	  	# $s4 = i
      	syscall

      	# PRINT MsgInputValuesFinal
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesFinal   	# MsgInputValuesFinal
      	syscall

        # GET VETOR_C[i] VALUE
        lw  $s5, 0($t1)            	# $s5 = Vetor_C[i]

      	# PRINT I
      	li  $v0, 1                	# chamada 1
      	add $a0, $0, $s5 	  	# $s5 = Vetor_C[i]
      	syscall

      	# ADDING INDEX LOOP ++
      	addi $s4, $s4, 1          	# i++
j	Print_Vetor_C			# goto Print_Vetor_C

Exit:	nop

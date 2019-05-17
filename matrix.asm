####################################################################
# Disciplina: Arquitetura e Organiza��o de Computadores
# Atividade: Avalia��o 02 - Programa��o em Linguagem de Montagem
# Programa 01
# Grupo: - Douglas Martins
# - Henrique Backes
#
####################################################################

#---------------------------------------------------- SETTING WHAT THE PROGRAM NEED -------------------------------------------------#

	.data
Matrix_A: 	          .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # Declara��o da Matrix A (max matrix_A[4][4])
Matrix_B: 	          .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # Declara��o da Matrix B (max matrix_B[4][4])
Matrix_C: 	          .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # Declara��o da Matrix C (max matrix_C[4][4])
MsgEnterSizeColumn:       .asciiz "\nEntre com o tamanho da coluna (m�x. = 4): "
MsgEnterSizeRow:       	  .asciiz "\nEntre com o tamanho da linha (m�x. = 4): "
MsgInputValuesBeginA:     .asciiz "\nEntre com o elemento A"
MsgInputValuesBeginB:     .asciiz "\nEntre com o elemento B"
MsgInputValuesBeginC:     .asciiz "\nC = "
MsgInputValuesMiddleOne:  .asciiz "["
MsgInputValuesMiddleTwo:  .asciiz "]"
MsgInputValuesFinal:      .asciiz " = "
MsgInputSpace:		  .asciiz " "
MsgInputJumpLine:	  .asciiz "\n    "
MsgWrongValue:      	  .asciiz "\nValor inv�lido"
MsgWrongMatrixToMult:     .asciiz "\nValor inv�lido! Coluna da matriz A tem que ser igual a Linha de matriz B" 
#---------------------------------------------------- SETTING WHAT THE PROGRAM NEED ---------------------------------------------------------#


	.text
j	main				# Pula para o label main


#------------------------------------------------------------- MSG_SIZE_COLUMN -------------------------------------------------------------#
Loop_Matrix_Column_Size:
Msg_Size_Column:	
	# PRINT READ SIZE MSG
	li   $v0, 4			# Chamada 4 (syscall code para imprimit uma String)
	la   $a0, MsgEnterSizeColumn	# MsgEnterSizeColumn
	syscall				# Executar a chamada do syscall
	
	# READ INT (SIZE)
	li   $v0, 5			# Chamada 5 (syscall code para ler um int)
	syscall				# Executar a chamada do syscall
	add  $t1, $v0, $0		# Salva o valor condito em $v0, em $t1 (Numero lido)
	
	# CONDITION (to stay or exit the Loop_Matrix_Size)
	slti $t0, $t1, 1			# if (size < 1) $t0 = 1 else $t0 = 0
	bgt  $t1, 4 Incorrect_Size_Column	# if (size > 4) goto Incorrect_Size_Column
	beq  $t0, 1, Incorrect_Size_Column	# if ($t0 == 1) goto Incorrect_Size_Column
	
jr	$ra				# goto Loop_Array_Size

Incorrect_Size_Column:
	# PRINT WRONG SIZE NUMBER MSG
	li  $v0, 4			# Chamada 4 (syscall code para imprimir uma String)
	la  $a0, MsgWrongValue		# MsgWrongValue
	syscall				# Executar a chamada do syscall
j	Msg_Size_Column			# goto Msg_Size_Column
#------------------------------------------------------------- MSG_SIZE_COLUMN -------------------------------------------------------------#


#------------------------------------------------------------- MSG_SIZE_ROW -------------------------------------------------------------#
Loop_Matrix_Row_Size:
Msg_Size_Row:	
	# PRINT READ SIZE MSG
	li   $v0, 4			# Chamada 4 (syscall code para imprimit uma String)
	la   $a0, MsgEnterSizeRow	# MsgEnterSizeRow
	syscall				# Executar a chamada do syscall
	
	# READ INT (SIZE)
	li   $v0, 5			# Chamada 5 (syscall code para ler um int)
	syscall				# Executar a chamada do syscall
	add  $t1, $v0, $0		# Salva o valor condito em $v0, em $t1 (Numero lido)
	
	# CONDITION (to stay or exit the Loop_Matrix_Size)
	slti $t0, $t1, 1		# if (size < 1) $t0 = 1 else $t0 = 0
	bgt  $t1, 4 Incorrect_Size_Row	# if (size > 4) goto Incorrect_Size_Row
	beq  $t0, 1, Incorrect_Size_Row	# if ($t0 == 1) goto Incorrect_Size_Row
	
jr	$ra				# goto Loop_Array_Size

Incorrect_Size_Row:
	# PRINT WRONG SIZE NUMBER MSG
	li  $v0, 4			# Chamada 4 (syscall code para imprimir uma String)
	la  $a0, MsgWrongValue		# MsgWrongValue
	syscall				# Executar a chamada do syscall
j	Msg_Size_Row			# goto Msg_Size_Row
#------------------------------------------------------------- MSG_SIZE_COLUMN -------------------------------------------------------------#


#------------------------------------------------------------- CHECK_MATRIX -----------------------------------------------------------------#
check_matrix:
while_check:
	# METHODS CALLED (SET COLUMN A VALUE)
	jal  Loop_Matrix_Column_Size	# Executa prodedimento para pegar um tamanho para coluna de uma matriz
	add  $s3, $t1, 0 		# Coluna_A = $s3 e $s3 = $t1 + 0
	
	# METHODS CALLED (SET ROW A VALUE)
	jal  Loop_Matrix_Row_Size	# Executa prodedimento para pegar um tamanho linha de uma matriz
	addi $s4, $t1, 0		# Linha_A = $s4 e $s4 = $t1 + 0
	
	# METHODS CALLED (SET COLUMN B VALUE)
	jal  Loop_Matrix_Column_Size	# Executa prodedimento para pegar um tamanho para coluna de uma matriz
	addi $s5, $t1, 0		# Coluna_B = $s5 e $s5 = $t1 + 0
	
	# METHODS CALLED (SET ROW B VALUE)
	jal  Loop_Matrix_Row_Size	# Executa prodedimento para pegar um tamanho para linha de uma matriz
	addi $s6, $t1, 0		# Linha_B = $s6 e $s6 = $t1 + 0
	
	# CONDITION (to stay or exit the check_matrix)
	bne  $s4, $s5, incorrect_Matrix_Mult 	# if (row_a != column_B) goto incorrect_matrix_mult
	
j	declare_matrix		

incorrect_Matrix_Mult: # adicionar syscall
	# PRINT WRONG MATRIX TO MULT
	li  $v0, 4			# Chamada 4 (syscall code para imprimir uma String)
	la  $a0, MsgWrongMatrixToMult	# MsgWrongMatrixToMult
	syscall				# Executar a chamada do syscall
j	while_check
#------------------------------------------------------------- CHECK_MATRIX -----------------------------------------------------------------#


#------------------------------------------------------------- LOOP_READ_A -----------------------------------------------------------------#
Loop_I_Read_A: # $a1 = row $a2 = column $a3 = base address matrix
	# CONDITION (I)
	slt  $t0, $t1, $a2                 # if (i < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Return_Procedure  # if ($t0 == 0) goto Return_Procedure

Loop_J_Read_A:
	# CONDITION (J)
	slt  $t0, $t3, $a1              # if (j < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Jump_Row_A       # if ($t0 == 0) goto Jump_Row_A

	# DESLOCAMENTO
        add  $t2, $t5, $t5         	# $t1 = 2.j
      	add  $t2, $t2, $t2         	# $t1 = 4.j
      	add  $t2, $t2, $a3         	# $t1 = end.base + 4.j (deslocamento) = end. de A[i][j]

      	# PRINT MsgInputValuesBeginA
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesBeginA   # MsgInputValuesBeginA
      	syscall

      	# PRINT MsgInputValuesMiddleOne
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesMiddleOne  # MsgInputValuesMiddleOne
      	syscall
      	
      	# PRINT I
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $t1 	  	# $t1 = index de Matriz[i]
      	syscall
      	
      	# PRINT MsgInputValuesMiddleTwo
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesMiddleTwo  # MsgInputValuesMiddleTwo
      	syscall
      	
      	# PRINT MsgInputValuesMiddleOne
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesMiddleOne  # MsgInputValuesMiddleOne
      	syscall
      	
      	# PRINT J
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $t3 	  	# $t3 = index de Matriz[j]
      	syscall
      	
      	# PRINT MsgInputValuesMiddleTwo
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesMiddleTwo  # MsgInputValuesMiddleTwo
      	syscall
      	
      	# PRINT MsgInputValuesFinal
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesFinal   # MsgInputValuesFinal
      	syscall

      	# READ INT
      	li   $v0, 5                	# chamada 5
      	syscall
      	add  $t4, $v0, $0          	# salva $v0 em $t4

	# STORE $t4 IN Matrix_[i][j]
      	sw   $t4, 0($t2)            	# salva $t4 no array Matrix_[i][j]
      	
      	# ADDING INDEX LOOP ++
        addi $t3, $t3, 1          	# j++
        addi $t5, $t5, 1		# aux++

j	Loop_J_Read_A			# goto Loop_J_Read_A

Jump_Row_A:
	# RESET J
	addi $t3, $zero, 0		# $t3 = 0

     	# ADDING INDEX LOOP ++
        addi $t1, $t1, 1          	# i++


j	Loop_I_Read_A			# goto Loop_Read_A
#------------------------------------------------------------- LOOP_READ_A ------------------------------------------------------------#


#------------------------------------------------------------- LOOP_READ_B ------------------------------------------------------------#
Loop_I_Read_B: # $a1 = row $a2 = column $a3 = base address matrix
	# CONDITION (I)
	slt  $t0, $t1, $a2                 # if (i < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Return_Procedure  # if ($t0 == 0) goto Return_Procedure

Loop_J_Read_B:
	# CONDITION (J)
	slt  $t0, $t3, $a1              # if (j < size) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Jump_Row_B     # if ($t0 == 0) goto Jump_Row_B

	# DESLOCAMENTO
        add  $t2, $t5, $t5         	# $t1 = 2.j
      	add  $t2, $t2, $t2         	# $t1 = 4.j
      	add  $t2, $t2, $a3         	# $t1 = end.base + 4.j (deslocamento) = end. de A[i][j]

      	# PRINT MsgInputValuesBeginB
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesBeginB   # MsgInputValuesBeginB
      	syscall

      	# PRINT MsgInputValuesMiddleOne
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesMiddleOne  # MsgInputValuesMiddleOne
      	syscall
      	
      	# PRINT I
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $t1 	  	# $t1 = index de Matriz[i]
      	syscall
      	
      	# PRINT MsgInputValuesMiddleTwo
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesMiddleTwo  # MsgInputValuesMiddleTwo
      	syscall
      	
      	# PRINT MsgInputValuesMiddleOne
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesMiddleOne  # MsgInputValuesMiddleOne
      	syscall
      	
      	# PRINT J
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $t3 	  	# $t3 = index de Matriz[j]
      	syscall
      	
      	# PRINT MsgInputValuesMiddleTwo
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesMiddleTwo  # MsgInputValuesMiddleTwo
      	syscall
      	
      	# PRINT MsgInputValuesFinal
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesFinal   # MsgInputValuesFinal
      	syscall

      	# READ INT
      	li   $v0, 5                	# chamada 5
      	syscall
      	add  $t4, $v0, $0          	# salva $v0 em $t4

	# STORE $t4 IN Matrix_[i][j]
      	sw   $t4, 0($t2)            	# salva $t4 no array Matrix_[i][j]
      	
      	# ADDING INDEX LOOP ++
        addi $t3, $t3, 1          	# j++
        addi $t5, $t5, 1		# aux++

j	Loop_J_Read_B			# goto Loop_J_Read_B

Jump_Row_B:
	# RESET J
	addi $t3, $zero, 0		# $t3 = 0

     	# ADDING INDEX LOOP ++
        addi $t1, $t1, 1          	# i++


j	Loop_I_Read_B			# goto Loop_Read_B
#------------------------------------------------------------- LOOP_READ_B ------------------------------------------------------------#


#------------------------------------------------------------- MULT MATRIX -------------------------------------------------------------------#	
mult_matrix:
	addi $sp, $sp, -4
	sw   $ra, 0($sp)
Loop_I_Read:
	# CONDITION (I)
	slt  $t0, $t1, $s4                 # if (i < linha_a) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, jump_main  	   # if ($t0 == 0) goto jump_main
        
        # ADDING INDEX LOOP ++
        addi $t1, $t1, 1		   # i++
        addi $t2, $zero, 0          	   # j = 0
        
Loop_J_Read: 
	# CONDITION (J)
	slt  $t0, $t2, $s3                 # if (j < coluna_B) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Loop_I_Read  	   # if ($t0 == 0) goto Loop_I_Read

Loop_K_Read:
	# CONDITION (K)
	slt  $t0, $t3, $s5                 # if (K < coluna_A) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Jump_Row  	   # if ($t0 == 0) goto Jump_Row
        
        # DESLOCAMENTO
        add  $t5, $t4, $t4         	# $t5 = 2.k
      	add  $t5, $t5, $t5         	# $t5 = 4.k
      	add  $t6, $t5, $s0         	# $t6 = end.base + 4.k (deslocamento) = end. de A[j][k]
      	
      	# LOAD MATRIX VALUES
	lw   $a0, 0($t6)            	# $a0 = A[j][k]
        
        # ADDING INDEX LOOP ++
        addi $t3, $t3, 1          	# k++
        addi $t4, $t4, 1		# aux++
        
j	Loop_K_Read			# goto Loop_K_Read

Jump_Row:
	# RESET K
	addi $t3, $zero, 0		# $t3 = 0
	
    	# ADDING INDEX LOOP ++
        addi $t2, $t2, 1          	# j++
        
j	Loop_J_Read			# goto Loop_J_Read

	
j	Loop_I_Read			# goto Loop_I_Read

jump_main:
	lw   $ra, 0($sp)
	addi $sp, $sp, 4
jr	$ra

#------------------------------------------------------------- MULT MATRIX -------------------------------------------------------------------#	


#------------------------------------------------------------- MULT ESCALAR -------------------------------------------------------------------#	
mult_escalar: # $a0 = matrix_a[i][j] $a1 = matrix_b[i][j]
	addi $sp, $sp, -8		
	sw   $t1, 4($sp)
	sw   $t0, 0($sp)
while:
	# CONDITION
	slt  $t0, $t1, $a0                 # if (i < matrix[i][j]) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, end_while 	   # if ($t0 == 0) goto end_while
        
        add  $v0, $v0, $a1		   # $vo = $va + $a1
        addi $t1, $t1, 1		   # i++
j	while				   # goto while
end_while:
	lw  $t0, 0($sp)
	lw  $t1, 4($sp)
	addi $sp, $sp, 8
jr	$ra				   # retorna o procedimento
#------------------------------------------------------------- MULT ESCALAR -------------------------------------------------------------------#	


#------------------------------------------------------------- RETURN PROCEDURE -------------------------------------------------------------------#
Return_Procedure:
jr	$ra				   # retorna o procedimento
#------------------------------------------------------------- RETURN PROCEDURE -------------------------------------------------------------------#


#------------------------------------------------------------- PRINT MATRIZ C -------------------------------------------------------------------#
Print_Matrix_C:
      	# PRINT MsgInputValuesBeginC
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputValuesBeginC   # MsgInputValuesBeginC
      	syscall
Loop_Print_C_I: # $a1 = row $a2 = column $a3 = base address matrix
	# CONDITION (I)
	slt  $t0, $t1, $a2                 # if (i < Coluna A) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Return_Procedure  # if ($t0 == 0) goto Return_Procedure

Loop_Print_C_J:
	# CONDITION (J)
	slt  $t0, $t3, $a1              # if (j < Linha B) $t0 = 1 else $t0 = 0
        beq  $t0, $zero, Jump_Row_C     # if ($t0 == 0) goto Jump_Row_C

	# DESLOCAMENTO
        add  $t2, $t5, $t5         	# $t1 = 2.j
      	add  $t2, $t2, $t2         	# $t1 = 4.j
      	add  $t2, $t2, $a3         	# $t1 = end.base + 4.j (deslocamento) = end. de A[i][j]
      	
      	lw   $t6, 0($t2)
      	
      	# PRINT ELEMENT
      	li   $v0, 1                	# chamada 1
      	add  $a0, $0, $t6 	  	# $t6 = Matriz[i][j]
      	syscall
      	
      	# PRINT MsgInputSpace
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputSpace   # MsgInputSpace
      	syscall
      	
      	# ADDING INDEX LOOP ++
        addi $t3, $t3, 1          	# j++
        addi $t5, $t5, 1		# aux++

j	Loop_Print_C_J			# goto Loop_Print_C_J

Jump_Row_C:
	# RESET J
	addi $t3, $zero, 0		# $t3 = 0

     	# ADDING INDEX LOOP ++
        addi $t1, $t1, 1          	# i++

	# PRINT MsgInputJumpLine
      	li   $v0, 4                	# chamada 4
      	la   $a0, MsgInputJumpLine      # MsgInputJumpLine
      	syscall

j	Loop_Print_C_I			# goto Loop_Print_C_I
#------------------------------------------------------------- PRINT MATRIZ C -------------------------------------------------------------------#


#------------------------------------------------------------- MAIN -------------------------------------------------------------------#
main:
	# METHOD ENTER ROW AND COLUMN MATRIX A AND B
	jal check_matrix
	
declare_matrix:
	# MAIN VARIABLES
	la   $s0, Matrix_A		# Carrega o Matrix_A[] no registrador $s0
	la   $s1, Matrix_B		# Carrega o Matrix_B[] no registrador $s1
	la   $s2, Matrix_C		# Carrega o Matrix_C[] no registrador $s2
	
	# METHODS CALLED (SET MATRIX A VALUES) $a1 = row $a2 = column $a3 = base address matrix
	addi $t1, $zero, 0		# $t1 = 0
	addi $t2, $zero, 0		# $t3 = 0
	addi $t3, $zero, 0		# $t3 = 0
	addi $t4, $zero, 0		# $t4 = 0
	addi $t5, $zero, 0		# $t5 = 0
	addi $a1, $s4, 0		# $a1 = $s4(Linha_A) + 0
	addi $a2, $s3, 0		# $a1 = $s3(Coluna_A) + 0
	addi $a3, $s0, 0		# $a1 = $s0(MatrizA end. base) + 0
	jal  Loop_I_Read_A		# Executa procedimento para entrar com os valores dos elementos da Matriz_A
	
	# METHODS CALLED (SET MATRIX B VALUES) $a1 = row $a2 = column $a3 = base address matrix
	addi $t1, $zero, 0		# $t1 = 0
	addi $t2, $zero, 0		# $t3 = 0
	addi $t3, $zero, 0		# $t3 = 0
	addi $t4, $zero, 0		# $t4 = 0
	addi $t5, $zero, 0		# $t5 = 0
	addi $a1, $s6, 0		# $a1 = $s6(Linha_B) + 0
	addi $a2, $s5, 0		# $a1 = $s5(Coluna_B) + 0
	addi $a3, $s1, 0		# $a1 = $s1(MatrizB end. base) + 0
	jal  Loop_I_Read_B		# Executa procedimento para entrar com os valores dos elementos da Matriz_B
	
	# RESETTING REGISTERS
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	addi $a0, $zero, 0
	addi $a1, $zero, 0
	addi $a2, $zero, 0
	addi $a3, $zero, 0
	addi $v0, $zero, 0
	
	# METHODS CALLED (MULT MATRIX)
	jal  mult_matrix
	
	# RESETTING REGISTERS
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	addi $a0, $zero, 0
	addi $a1, $s3, 0
	addi $a2, $s6, 0
	addi $a3, $s2, 0
	
	# METHOD CALLED (PRINT MATRIZ C)
	jal  Print_Matrix_C
	
	
	nop
#------------------------------------------------------------- MAIN -----------------------------------------------------------------#


	

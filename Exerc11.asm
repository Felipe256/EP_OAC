.text
.globl main
main:
	li $a3, 20 #variavel para parada do loop, min: 1 max: infinito
	subu $sp, $sp, 20 #coloca 5 espacos na pilha
	li $a0, 2 #valor de G2
	sw $a0, 16($sp)
	li $a0, 1 #valor de F2
	sw $a0, 12($sp) 
	li $a0, 1 #valor de G1
	sw $a0, 8($sp) 
	li $a0, 2 #valor de F1
	sw $a0, 4($sp) 
	li $a0, 1 #valor de i
	sw $a0, 0($sp) 
	#jal imprimeValor
	jal loop
	li $v0, 10
	syscall 
loop:
	lw $a0, 0($sp)
	addu $sp, $sp, 4 #remove um espaco da pilha
	subu $sp, $sp, 4 #coloca 1 espaco na pilha
	sw $ra, 0($sp)
	subu $sp, $sp, 4 #coloca 1 espaco na pilha
	sw $a0, 0($sp)
	jal imprimeValor
	lw $a0, 0($sp)
	addu $sp, $sp, 4 #remove um espaco da pilha
	lw $ra, 0($sp)
	addu $sp, $sp, 4 #remove um espaco da pilha
	addu $a0, $a0, 1
	subu $sp, $sp, 4
	sw $a0, 0($sp)
	ble  $a0, $a3, calcula #if(i <= limiter)
	jr $ra #if(i > limiter)
calcula:
	lw $a0, 4($sp) #valor para F(i-2)
	lw $a1, 12($sp) #valor para F(i-1)
	sw $a1, 4($sp) #novo valor para F(i-2)
	mul $a1, $a1, 2 #calcula 2*F(i-1)
	lw $a2, 8($sp) #valor para G(i-2)
	addu $a1, $a1, $a2 #calcula 2*F(i-1) + G(i-2)
	sw $a1, 12($sp) #novo valor F(i-1)
	lw $a1, 16($sp) #valor para G(i-1)
	sw $a1, 8($sp) #novo valor G(i-2)
	mul $a0, $a0, 3 #calcula 3*F(i-2)
	addu $a0, $a0, $a1 #calcula  G(i-1)+3*F(i-2)
	sw $a0, 16($sp) #novo valor G(i-1)
	j loop
imprimeValor:
	lw $a1, 0($sp) #recebe o valor de i
	addu $sp, $sp, 4 #remove um espaco da pilha
	
	la $a0, letraF #colocando a letra F para imprimir
	li $v0, 4 #codigo pra imprimir caracteres
	syscall
	addu $a0, $a1, 0 #prepara o valor de i para ser impresso
	li $v0, 1 #codigo pra imprimir inteiro
	syscall
	la $a0, doisPontos #colocando dois pontos para imprimir
	li $v0, 4 #codigo pra imprimir caracteres
	syscall
	lw $a0, 4($sp) #colocando o valor de F(i) para imprimir
	li $v0, 1 #codigo pra imprimir inteiro
	syscall
	la $a0, virgula #colocando virgula para imprimir
	li $v0, 4 #codigo pra imprimir caracteres
	syscall
	la $a0, letraG #colocando a letra G para imprimir
	syscall
	addu $a0, $a1, 0 #prepara o valor de i para ser impresso
	li $v0, 1 #codigo pra imprimir inteiro
	syscall
	la $a0, doisPontos #colocando dois pontos para imprimir
	li $v0, 4 #codigo pra imprimir caracteres
	syscall
	lw $a0, 8($sp) #colocando o valor de G(i) para imprimir
	li $v0, 1 #codigo pra imprimir inteiro
	syscall
	la $a0, quebraLinha #colocando quebra de linha para imprimir
	li $v0, 4 #codigo pra imprimir caracteres
	syscall
	
	subu $sp, $sp, 4 #coloca 1 espaco na pilha
	sw $a1, 0($sp) #recebe o valor de i
	jr $ra
.data
quebraLinha: .asciiz "\n"
doisPontos: .asciiz ": "
letraF: .asciiz "F"
letraG: .asciiz "G"
virgula: .asciiz ", "

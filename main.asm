.data
	#Ambiente para instanciar variaveis
	year: .word 2022
	grettings: .asciiz "\nBem-vindo a calculadora assembliana! \nQual operação deseja realizar?\n"
	options: .asciiz  "1- Soma \n2- Subtração \n3- Multiplicação \n4- Divisão \n5-Exponenciação \n6- sair\n: "
	firstNumber: .asciiz "\nDigite um número: "
	secondNumber: .asciiz "\nDigite outro número: "
	
	.macro soma
	
		add $s0, $s1, $s2 #soma dois números
		
		li $v0, 1 #informa que um número inteiro vai ser impresso na tela
		move $a0, $s0 #carrega o resultado para o registrador se saída
		syscall	
	.end_macro
	
	.macro subtrair
		sub $s0, $s1, $s2 #soma dois números
	
		li $v0, 1 #informa que um número inteiro vai ser impresso na tela
		move $a0, $s0 #carrega o resultado para o registrador se saída
		syscall	
	.end_macro 
	
	.macro multiplicar
		mul $s0, $s1, $s2 #soma dois números
	
		li $v0, 1 #informa que um número inteiro vai ser impresso na tela
		move $a0, $s0 #carrega o resultado para o registrador se saída
		syscall	
	.end_macro
	
	.macro dividir
		div $s0, $s1, $s2 #soma dois números
	
		li $v0, 1 #informa que um número inteiro vai ser impresso na tela
		move $a0, $s0 #carrega o resultado para o registrador se saída
		syscall
	.end_macro
.text
	#Ambiente de desenvolvimento
	
	li $v0, 1
	lw $a0, year #mostra o ano
	syscall
	
	li $v0, 4
	la $a0, grettings #mostra a mensagem de boas-vindas
	syscall 
	
	#Inicia a calculadora
	li $v0, 4
	la $a0, options #fornece as opções
	syscall
	
	li $v0, 5 #lê uma opção 
	syscall
	
	move $t0, $v0 #move a opção para uma variavel temporária
	
	li $v0, 4
	la $a0, firstNumber #mensagem para ler o primeiro número
	syscall
	
	li $v0, 5 #lê o primeiro número
	syscall
	
	move $s1, $v0 #move o primeiro número para uma variável temporária
	
	li $v0, 4
	la $a0, secondNumber #mensagem para ler o primeiro número
	syscall
	
	li $v0, 5 #lê outro número
	syscall
	
	move $s2, $v0 #move outro número para uma variável temporária
	
	#executar a opção escolhida
	beq $t0, 1, adicao
	beq $t0, 2, subtracao
	beq $t0, 3, multiplacao
	beq $t0, 4, divisao
	beq $t0, 6, sair
	
	li $v0, 10
		syscall	
	
	adicao: 	
		soma
		li $v0, 10
		syscall
		
		
	
	subtracao: 	
		subtrair	
		li $v0, 10
		syscall
		
		
	
	multiplacao: 	
		multiplicar
		li $v0, 10
		syscall
	
	
	
	divisao: 	
		dividir
		li $v0, 10
		syscall
	
			
	
	sair: 	
		li $v0, 10
		syscall
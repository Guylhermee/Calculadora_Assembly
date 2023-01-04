.data
	#Ambiente para instanciar variaveis
	year: .word 2023
	grettings: .asciiz "\nBem-vindo a calculadora assembliana! \nQual operação deseja realizar?\n"
	options: .asciiz  "\n1- Soma \n2- Subtração \n3- Multiplicação \n4- Divisão \n5-Raiz Quadrada \n6- sair\n: "
	firstNumber: .asciiz "\nDigite um número: "
	secondNumber: .asciiz "\nDigite outro número: "
	
	.macro ler_inteiro #Função para ler os dois números inteiros do cálculo.
		li $v0, 4 #chamada de sistema para imprimir uma string
		la $a0, firstNumber #mensagem para ler o primeiro número, carrega o valor de "firstNumber" para a0
		syscall
	
		li $v0, 5 #chamada de sistema para ler primeiro número inteiro
		syscall
	
		move $s1, $v0 #move o primeiro número para uma variável temporária
	
		li $v0, 4
		la $a0, secondNumber #mensagem para ler o segundo número
		syscall
	
		li $v0, 5 #chamada de sistema para ler o segundo número inteiro
		syscall
	
		move $s2, $v0 #move o segundo número para uma variável temporária
	.end_macro
	
	
	.macro soma
		ler_inteiro #executa o macro de ler os números inteiros
		add $s0, $s1, $s2 #soma dois números e armazena em s0
		
		li $v0, 1 #chamada de sistema para imprimir número inteiro
		move $a0, $s0 #carrega o resultado para o registrador se saída
		
		syscall	
	.end_macro
	
	.macro subtrair
		ler_inteiro
		sub $s0, $s1, $s2 #subtrai dois números e armazena em s0

		li $v0, 1 #chamada de sistema para imprimir número inteiro
		move $a0, $s0 #carrega o resultado para o registrador de saída
		syscall	
	.end_macro 
	
	.macro multiplicar
		ler_inteiro
		mul $s0, $s1, $s2 #multiplica dois números e armazena em s0
	
		li $v0, 1 #chamada de sistema para imprimir número inteiro
		move $a0, $s0 #carrega o resultado para o registrador de saída
		syscall	
	.end_macro
	
	.macro dividir
		li $v0, 4
		la $a0, firstNumber #mensagem para ler o primeiro número
		syscall
	
		li $v0, 6 #chamada de sistema para ler o primeiro número real
		syscall
		mov.s $f1,$f0 #armazena o float digitado
		
		li $v0, 4
		la $a0, secondNumber #mensagem para ler o segundo número
		syscall
	
		li $v0, 6 #chamada de sistema para ler o segundo número real
		syscall
		mov.s $f3,$f0 #armazena o número real digitado
		
		div.s $f5,$f1,$f3 #divide os números e armazena em f5
		mov.s $f12,$f5 #carrega o resultado para ser impresso
		li $v0, 2 #informa que um número real vai ser impresso na tela
		syscall
	.end_macro
	
	.macro raiz_quadrada
		li $v0, 4
		la $a0, firstNumber #mensagem para ler o primeiro número
		syscall
	
		li $v0, 6 #lê o número real
		syscall
		mov.s $f1,$f0 #armazena o número real digitado
		
		sqrt.s $f5, $f1 #calcula a raíz quadrada e armazena em em f5
		mov.s $f12, $f5 #carrega o resultado para o registrador de saída
		li $v0,2 #chamada de sistema para imprimir valor real
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
	loop:	#laço de repetição
		li $v0, 4 #imprime uma string
		la $a0, options #fornece as opções
		syscall
	
		li $v0, 5 #lê o valor inteiro da opção selecionada
		syscall
		
		move $t0, $v0 #move a opção para uma variavel temporária
	
		#executar a opção escolhida
		beq $t0, 1, adicao #condicional para cada uma das opções
		beq $t0, 2, subtracao
		beq $t0, 3, multiplacao
		beq $t0, 4, divisao
		beq $t0, 5, raiz
		beq $t0, 6, sair
	
		li $v0, 10 #Sair do programa
		syscall	
		
		j loop #laço de repetição para cada uma das funções
		
	adicao: 	
		soma
		j loop
		
	subtracao: 	
		subtrair	
		j loop
	
	multiplacao: 	
		multiplicar
		j loop
	
	divisao: 	
		dividir
		j loop
		
	raiz: 	
		raiz_quadrada
		j loop
	
	sair: 	
		li $v0, 10 #Sair do programa
		syscall
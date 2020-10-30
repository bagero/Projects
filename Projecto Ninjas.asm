;************************************************************************************
;*		Entrega Final - IAC														    *
;*			Grupo 36															    *
;*		Maria Alice Cruz - 8206													    *
;*		Tiago Castro - 84770													    *
;*		Tiago Garcia - 84771													    *
;*																				    *
;************************************************************************************

;************************************************************************************
;* Constantes 																   	    *
;************************************************************************************
LINHA			EQU	1				; posição do bit correspondente à linha (1) 
FIM_LINHA		EQU 16 			; necessario no teclado
PIN				EQU	0E000H			; endereço do porto de E do teclado
POUT1  			EQU 0A000H  		;
POUT2  			EQU 0C000H  		;
PIXEL_S			EQU	8000H 			; endereco inicio da pixelscreen
PIXEL_E			EQU	807FH			; endereco maximo da pixelscreen
END_CONV		EQU 2000H
MASCARA 		EQU 240
NINJA_L 		EQU 4
NINJA_C			EQU 3
ARMA_L			EQU 3
ARMA_C			EQU 3
PRESENTE_L		EQU 3
PRESENTE_C		EQU 3
ON				EQU 1
OFF				EQU 0
CIMA_N1			EQU 0
BAIXO_N1		EQU 4
CIMA_N2			EQU 1
BAIXO_N2		EQU 5
CIMA_N3			EQU 2
BAIXO_N3		EQU 6
CIMA_N4			EQU 3
BAIXO_N4		EQU 7
d_START			EQU 0CH
PAUSE			EQU 0DH
d_END 			EQU 0EH
RANDOM_NUM 		EQU 1AH
LIM_INF			EQU 1BH
LIM_SUP			EQU 00H
gera			EQU 05H
;DEZ  			EQU 0AH










PLACE 3000H
GAME: 	STRING 0003H, 00CFH, 0045H, 00c0H, 0002H, 0049H, 006DH, 0000H
		STRING 0002H, 0009H, 0055H, 0000H, 0002H, 006FH, 0045H, 0080H
		STRING 0002H, 0029H, 0045H, 0000H, 0003H, 00E9H, 0045H, 00C0H

OVER:  	STRING 0001H, 0091H, 0073H, 0000H, 0002H, 0051H, 0044H, 0080H
		STRING 0002H, 0051H, 0044H, 0080H, 0002H, 004AH, 0067H, 0000H
		STRING 0002H, 004AH, 0044H, 0080H, 0001H, 0084H, 0074H, 0080H

START: 	STRING 000EH, 00F9H, 0013H, 00E0H, 0008H, 0022H, 00A8H, 0080H
		STRING 000EH, 0023H, 00B0H, 0080H, 0002H, 0022H, 00A8H, 0080H
		STRING 000EH, 0022H, 00A4H, 0080H



PLACE 2000H


CONVERSOR:   WORD 0
			 WORD 0
			 WORD 1
			 WORD 0
			 WORD 2
			 WORD 0
			 WORD 0
			 WORD 0
			 WORD 3


;************************************************************************************
;* Variaveis                                                                        *
;************************************************************************************

PLACE 1000H

TECLA : 	 String 0		;Variavel para guardar a tecla
NINJA1:		 String 1		;Flag para verificar a operacao a realizar
NINJA2:		 String 1
NINJA3:		 String 1
NINJA4:		 String 1							;0-nada 1-somatecla 2-subtraitecla 3-soma3 4-subtrai3
PUTu  :      String 0 		;Variavel para guardar as unidades
PUTd  :		 String 0 		;Variavel para guardar as dezenas
NINJA:			String 0,1,0,1,1,1,0,1,0,1,0,1
apaga_NINJA: 	String 0,0,0,0,0,0,0,0,0,0,0,0
POSICAO_NINJA1:	String 10, 0
POSICAO_NINJA2: String 10, 4
POSICAO_NINJA3: String 10, 8
POSICAO_NINJA4: String 10, 12
pos_random1:		String 25, 0
pos_random2:		String 0, 0
ARMA:   		String 1,0,1,0,1,0,1,0,1
apaga_ARMA: 		String  0,0,0,0,0,0,0,0,0
PRESENTE:		String 0,1,0,1,1,1,0,1,0
apaga_PRESENTE: String 0,0,0,0,0,0,0,0,0
d_inicio: 		String 1
flag:			String 4
FLAG_ARMA: 		String 5
muda_operacao:  String 0
colisao_arma:	String 1
colisao_presente: String 0
houve_pausa: 	String 0



tecla:	String -1


;************************************************************************************
;* Pilha                                                                            *
;************************************************************************************


PLACE     		4000H
PILHA:    		TABLE 300H     		; espaco reservado para a pilha
SP_inicial :					; 
PLACE 	 		4500H

INT:			WORD desce_ninja
				WORD move_objeto
				



;************************************************************************************
;* Codigo                                                                           *
;************************************************************************************
;*                                                                                  *
;* Inicializacoes                                                                   *
;*                                                                                  *
;************************************************************************************


PLACE			0H
					


inicio:				MOV SP, SP_inicial
					MOV BTE, INT
					MOV R1, d_inicio
					MOVB R2, [R1]
					CMP R2, 1
					JNZ ciclo_inicial

inicio1:
					CALL limpa_ecra
					CALL START_S
					
					PUSH R1
					PUSH R2
					MOV R1, d_inicio
					MOVB R2, [R1]
					CMP R2, 1
					JNZ ciclo_inicial
					MOV R2, 0
					MOVB [R1], R2
					POP R2
					POP R1
					
					
ciclo_inicial:		MOV SP, SP_inicial
					DI0
					DI1
					CALL Teclado
					CALL update_jogo		




move_objeto:		
				  ;CALL actualiza_objeto
desce_ninja:
			     ; CALL actualizaninja
				  RFE


actualizaobjeto:
				  PUSH R1
				  PUSH R2
				  PUSH R3
				  PUSH R4
				  PUSH R5
				  PUSH R6
				  PUSH R7
				  PUSH R9
				  PUSH R10
				  CALL gera_mov_esquerda
				  CALL desce_ninja
				  CALL limpa_ecra
				  CALL refresh_screen
				
				

				  POP R10
				  POP R9
				  POP R8
				  POP R7
				  POP R6
				  POP R5
				  POP R4
				  POP R3
				  POP R2
				  POP R1

gera_mov_esquerda:    					; o  valor da variavel varia entre 0 e 2 
				    PUSH R1
				    PUSH R2
				    PUSH R3
				    PUSH R4
				    PUSH R5
				    PUSH R6
				    MOV R8, muda_operacao
				    MOV R1, pos_random1
				    ADD R1, 1
				    MOVB R2, [R1]
				    MOV R3, LIM_SUP
				    CMP R2, R3
				    JZ 	gera_random
				    SUB R2, 1
				    MOVB [R1], R2
POPS:			    SUB R1, 1
					MOVB [R1], R6
				    POP R6
				    POP R5
				    POP R4
				    POP R3
				    POP R2
				    POP R1
				    RET

gera_random:				
					
					MOV R7, pos_random2
					MOVB R6, [R8]
					CMP R6, 0 
					JZ aux_desce
					CMP R6, 1
					JZ aux_sobe

					 

					
aux_desce:			MOVB R6, [R7]
					;CMP R6, LIM_INF
					JZ refresh_desce
aux1:				MOV R4, gera
					MOVB R5, [R4]
					;ADD R6, R5
					MOVB [R7], R6					
					ADD R7, 1
					MOV R4,1
					MOVB [R8], R4
					JMP POPS
					

aux_sobe:			
					
					MOVB R6, [R7]
					;CMP R6, LIM_SUP
					JZ refresh_sobe
aux2:				MOV R4, gera
					MOVB R5, [R4]
					;ADD R6, R5
					MOVB [R7], R6
					SUB R7, 1
					MOV R4, 0
					MOVB [R8], R4
					JMP POPS

refresh_desce:		;MOV R6, LIM_SUP
					JMP aux1

refresh_sobe:		;MOV R6, LIM_INF
					JMP aux2


		





actualiza_ninja:	PUSH R0
					PUSH R1
					MOV R0, POSICAO_NINJA1
					MOVB R1, [R0]
					ADD R1, 1
					MOVB [R0], R1
					MOV R0, POSICAO_NINJA2
					MOVB R1, [R0]
					ADD R1, 1
					MOV R0, POSICAO_NINJA3
					MOVB R1, [R0]
					ADD R1, 1
					MOVB [R0], R1
					MOV R0, POSICAO_NINJA4
					MOVB R1, [R0]
					ADD R1, 1
					MOVB [R0], R1
					POP R1
					POP R0


					


;************************************************************************************
;* Funcoes para limpar o pixel screen
;************************************************************************************
limpa_ecra:			PUSH R1
					PUSH R8
					PUSH R9
					MOV R8, PIXEL_S		    ;Movemos o endereco do inicio
					MOV R1,00H 				;Metemos no R1 0 cmo auxiliar para apagar
					MOV R9, PIXEL_E
					ADD R9,1


ciclo_limpa:		MOVB [R8],R1			; apagar que e por zeros
					ADD R8,1				; ir para o prox endereco do pixelscreen
					CMP R8,R9				; ate chegar ao ultimo endereco
					JNZ ciclo_limpa
					POP R9
					POP R8
					POP R1
					RET

;************************************************************************************
;* Escreve o inicio do programa                                                     *
;************************************************************************************


START_S:				PUSH R0
						PUSH R1
						PUSH R4
						MOV R0, START
						MOV R4, 8
						MOV R1, 6
						CALL escreve_final
						POP R4
						POP R1
						POP R0
		
						

;************************************************************************************
;* Teclado- este bloco serve para reconhecer qual a tecla premida                   *
;*			Guarda o valor da tecla premida em R8 (ja convertido)                   *
;************************************************************************************


Teclado:	PUSH R0
			PUSH R1
			PUSH R2
			PUSH R3
			PUSH R4
			PUSH R5
			PUSH R6
			PUSH R7
			PUSH R9
			PUSH R10
			MOV R10, POUT2		  
			MOV R6, FIM_LINHA	  ;Ultima linha do teclado        
		    MOV  R1, LINHA        
		    MOV  R2, PIN  		  ;R2 com o endereco do periferico
		    MOV R0, TECLA
		    JMP verifica
		    
						
ciclo:		SHL R1, 1		    ;Varrimento das linhas
			CMP R1,R6			;Verifica se esta na ultima linha
			JNZ verifica 	    ;Se nao estiver continua o varrimento 
			MOV R1, LINHA		;Caso contrario verifica a primeira novamente


verifica:	MOVB [R10], R1		;Escreve no periferico de saida
		    MOVB R3, [R2]       ;Le do periferico de entrada
		    AND R3, R3          ;Verifica se houve tecla primida
		    JZ   ciclo          ;Ve se a tecla foi premida, se sim avanca
		    MOV  R4, R3         ;Guarda o valor da coluna
			MOV R7, END_CONV	;Inicia o conversor
			MOV R8, 2			;Constante para aplicar a formula l,c
			MUL R4, R8
			MUL R8,R1			;Multiplica a coluna e a linha por 2, visto que o 						;enderecamento e de 2 em 2
			ADD R8,R7			
			ADD R4,R7			;Numeros de endereco do conversor para a respetiva 					;linha e coluna
			MOV R8, [R8]		
			MOV R4, [R4]		;Converte
			MOV R7, 4
			MUL R8, R7
			ADD R8, R4 			;Aplica formula 4 * LINHA + COLUNA
			MOV R7, MASCARA		
			ADD R8,R7			;Mascara a tecla premida 
			SHL R8, 12			
			ROL R8, 4			;Mete os primeiros 8 bits com o valor da coluna e linha
								;respetivamente


ha_tecla:   MOV R1, LINHA   	;Guarda o valor da linha da tecla premida
			MOV [R10], R1       
			MOV R3, [R2]		;Le do periferico das colunas se existe tecla premida
			CMP R3, 0			
			JNZ ha_tecla        ;Testa sucessivamente ate o valor do periferico ser 0
								;sendo 0 avanaca para o fim 			

	
fim: 		MOVB [R0],R8    	;Guarda a tecla premida na variavel
			POP R10
			POP R9
			POP R7
			POP R6
			POP R4
			POP R3
			POP R2
			POP R1
			POP R0
			JMP update_jogo			;Reinicia procura de tecla premida	


;************************************************************************************
; Funcoes para desenhar o frame desejado                                            *
;************************************************************************************
					
refresh_screen:		MOV R10, POSICAO_NINJA1  	
					MOVB R1, [R10]
					ADD R10, 1
					MOVB R3, [R10]
					MOV R0, NINJA1
					CALL atualiza_jogo

ninja2:				MOV R10, POSICAO_NINJA2 	
					MOVB R1, [R10]
					ADD R10, 1
					MOVB R3, [R10]
					MOV R0, NINJA2					
					CALL atualiza_jogo

ninja3:				MOV R10, POSICAO_NINJA3 	
					MOVB R1, [R10]
					ADD R10, 1
					MOVB R3, [R10]
					MOV R0, NINJA3
					CALL atualiza_jogo

ninja4:				MOV R10, POSICAO_NINJA4 	
					MOVB R1, [R10]
					ADD R10, 1
					MOVB R3, [R10]
					MOV R0, NINJA4
					CALL atualiza_jogo

;arma:				

					;MOV R10, pos_random1
					;MOVB R1, [R10]
					;ADD R10, 1
					;MOVB R3, [R10]
					;MOV R0, FLAG_ARMA
					;MOVB R10, [R0]
					;CMP R10, 0AH
					;JZ muda_para_presente
					;Call atualiza_jogo
					JMP update_jogo1_final

;muda_para_presente:	MOV R10, 5






					
update_jogo1_final:	RET

atualiza_flag:		MOV R0, flag
					MOVB R10, [R0]
					SUB R10,1
					MOVB [R0], R10
					CMP R10, 0
					JZ go_on
					RET
					

flag_final:			CALL game_over
go_on:				RET


; ***********************************************************************************
; * Funcoes aritmeticas - soma ou subtrai 3 se o ninja colidir com objeto           *
;							da update nos displays( nao utilizadas)                 *
; ***********************************************************************************


ganha_pontos:	MOV R2, colisao_arma
				CMP R1, R2			    
				JNZ	morre_ninja			    
				MOV R3,3			   
				JMP adiciona_unidades


morre_ninja:		MOV R2, colisao_presente							
					MOV R3,3				
					JMP remove_unidades

remove_unidades:
			CMP R3,0
			JZ  update_displays
			MOV R7,0
			CMP R9,R7
			JZ remove_dezenas
			SUB R5,1
			SUB R9,1
			SUB R3,1
			JMP remove_unidades
	
remove_dezenas:	
			CMP R10,0
			JZ update_displays
			SUB R10,1
			MOV R9,9
			MOV R0, PUTd
			MOVB [R0], R10 ; dezenas
			MOV R0, PUTu
			MOVB [R0], R9 ; unidades
			SUB R3,1
			JMP remove_unidades
	
	
adiciona_unidades:
			CMP R3,0
			JZ update_displays
			MOV R7,9
			CMP R9,R7
			JZ adiciona_dezenas
			ADD R5,1
			ADD R9,1
			SUB R3,1
			JMP adiciona_unidades

adiciona_dezenas:
			MOV R2,9
			CMP R10,R2
			JZ update_displays
			ADD R10,1
			MOV R9,0
			MOV R0, PUTd
			MOVB [R0], R10 ; dezenas
			MOV R0, PUTu
			MOVB [R0], R9 ; unidades
			SUB R3,1
			JMP adiciona_unidades
 update_displays:
			MOV R5,10H
			MUL R5, R10
			ADD R5,R9
			MOV R4,POUT1
			MOVB [R4],R5
			MOV R0, PUTd
			MOVB [R0], R10 ; dezenas
			MOV R0, PUTu
			MOVB [R0], R9 ; unidades

;************************************************************************************
; Funcoes pixel screen - Neste bloco encontram se as funcoes de desenho do pixel    *
;                        screen (desenhar/apagar)                                   *

;************************************************************************************
; Funcoes para desenhar o ecra inicial                                              *
;************************************************************************************

atualiza_jogo:		PUSH R0
					PUSH R1
        			PUSH R2
        			PUSH R3
        			PUSH R4
        			PUSH R5
        			PUSH R6
        			MOVB R10, [R0]            		;verifica estado do ninja a desenhar
        			CMP R10, 0						;0- nao desenha , 1 - desenha
        			JZ atualiza_jogo_final
        			CMP R10, 5						;verifica se foi chamado para desenhar 
        			JZ cria_arma					;a arma se sim salta para cria_arma 
        			MOV R8, NINJA_L					; caso contrario desenha os ninja na posicao
        			MOV R9, NINJA_C					;actual	
        			MOV R4, NINJA
        			CALL desenha_objeto
atualiza_jogo_final:	POP R6
        			POP R5
        			POP R4
        			POP R3  
        			POP R2
        			POP R1
        			POP R0
        			RET

cria_arma:			PUSH R1
        			PUSH R2
        			PUSH R3
        			PUSH R4
        			PUSH R5
        			PUSH R6
        			;CMP R10, 10						;verifica se foi chamado para desenhar 
        			JZ cria_presente				;o presente se sim salta para 
        			MOV R8, ARMA_L					;cria_presente
        			MOV R9, ARMA_C					;caso contrario desenha a arma
        			MOV R4, ARMA 					
        			CALL desenha_objeto
        			POP R6
        			POP R5
        			POP R4
        			POP R3  
        			POP R2
        			POP R1
        			RET


cria_presente:     	PUSH R1
        			PUSH R2
        			PUSH R3
        			PUSH R4
        			PUSH R5
        			PUSH R6
        			MOV R8, PRESENTE_L         ;
        			MOV R9, PRESENTE_C
        			MOV R4, PRESENTE
        			CALL desenha_objeto
        			POP R6
        			POP R5
        			POP R4
        			POP R3  
        			POP R2
        			POP R1
        			RET



desenha_objeto:		PUSH R1
            		PUSH R2
            		PUSH R3
            		PUSH R4
            		PUSH R5
            		PUSH R6
            		PUSH R7
            		PUSH R8
            		PUSH R10
					SUB R1,1
					SUB R3, 1
					MOV R10, R9
					MOV R0, R3


desenha_linha:		MOV R9, R10
					MOV R3,R0
					ADD R1, 1
					SUB R8,1
					JN desenha_objeto_fim


desenha_coluna:		ADD R3, 1
					MOVB R2, [R4]	
					CALL escreve_pixel
					ADD R4,1
					SUB R9,1
					JZ  desenha_linha
					JMP desenha_coluna


desenha_objeto_fim:	POP R10
		            POP R8
		            POP R7
		            POP R6
		            POP R5
		            POP R4
		            POP R3
		            POP R2
		            POP R1
					RET


escreve_pixel:		PUSH R1
					PUSH R3
					PUSH R4
					PUSH R6
					PUSH R9
					CALL encontra_linha   ; recebe R1 e R6 agora e a parte do 
										  ; endereco do pixel da linha 
					MOV R9,R6
					CALL encontra_coluna  ; recebe R3 e R3 e agora a parte do 
										  ; endereco do pixel total
					ADD R9, R3
					CMP R2, 0			  ; R4 e o bit a acender/apagar
					JNZ pixel_on		  ; se R2=1 entao e para acender
					CMP R2, 0
					JZ pixel_off 		  ; se R2=0 entao e para apagar


pixel_escrito:		POP R9
					POP R6
					POP R4
					POP R3
					POP R1
					RET		


encontra_linha:		PUSH R5 								; R6 = Pixel + 4xLinha
					PUSH R1 								; R6 fica destruido
					MOV R5, 4
					MUL R1, R5
					MOV R6, PIXEL_S
					ADD R6, R1
					POP R1
					POP R5
					RET	


encontra_coluna:	PUSH R5 			; endereco do pixelscreen
					MOV R4, 80H
					MOV R5, 0 			; Contador de oitos inteiros
					MOV R6, 8 		    ; para comparar com oito
					CMP R3, R6 		    ; se nao se precisar de retirar oitos
					JLT inferior_8   	; o numero ja e menor que oito, alterado ou nao


remove_8:			SUB R3, R6
					ADD R5, 1 		 ; de maneira a guardar quantos oitos tiramos
					CMP R6, R3
					JNP remove_8 

inferior_8:			
verifica_byte:		AND R3, R3
					JZ encontra_coluna_fim
					SUB R3,1            ; subtrai um a coluna para que se conte o
										; quanto se precisa
					SHR R4,1  			; de andar para a direita com o um 
					JMP verifica_byte


encontra_coluna_fim: MOV R3, R5
					 POP R5
					 RET


pixel_on:			PUSH R5
					MOVB R5, [R9]
					OR R5, R4					
					MOVB [R9], R5
					POP R5
					JMP pixel_escrito

pixel_off:			PUSH R5
					MOVB R5, [R9]
					NOT R4
					AND R5, R4
					MOVB[R7], R5
					POP R5
					JMP pixel_escrito

;************************************************************************************
;*   update_jogo - varrimento do teclado / alteracoes a posicoes                    *
;************************************************************************************


			
		
update_jogo:	MOV R0, TECLA
				MOVB R1, [R0]
				MOV R2, d_START
				CMP R1, R2 	   		;Verificamos se a tecla premida e a tecla de start
				JNZ	pausa
				CALL limpa_ecra		;se for limpa ecra e da reset a tudo, posicoes, score
				MOV R8, NINJA1 		;flags
				MOV R6, 1
				MOVB [R8], R6
				MOV R8, NINJA2
				MOV R6, 1
				MOVB [R8], R6
				MOV R8, NINJA3
				MOV R6, 1
				MOVB [R8], R6
				MOV R8, NINJA4
				MOV R6, 1
				MOVB [R8], R6
				MOV R8, flag
				MOV R6, 4
				MOVB [R8], R6
				MOV R8, POSICAO_NINJA1
				MOV R6, 10
				MOVB [R8], R6
				MOV R8, POSICAO_NINJA2
				MOV R6, 10
				MOVB [R8], R6
				MOV R8, POSICAO_NINJA3
				MOV R6, 10
				MOVB [R8], R6
				MOV R8, POSICAO_NINJA4
				MOV R6, 10
				MOVB [R8], R6
				MOV R8, 0
				MOV R6, POUT1
				MOV [R6], R8
				MOV R6, houve_pausa
				MOVB [R6], R8
				CALL refresh_screen    ;desenha o novo frame
				JMP ciclo_inicial

pausa:			MOV R2, PAUSE    			;nao funciona apenas procura outra tecla
				CMP R1, R2
				JNZ CASE0
				MOV R5, houve_pausa
				MOV R2, 1
				MOVB [R5], R2
				;JMP
				JMP ciclo_inicial 





CASE0:			MOV R2, CIMA_N1
				CMP R1, R2
				JNZ CASE1
				MOV R5, POSICAO_NINJA1
				JMP SOBE

CASE1:			MOV R9, NINJA1
				MOV R2, BAIXO_N1
				CMP R1, R2
				JNZ CASE2
				MOV R5, POSICAO_NINJA1
				JMP DESCE

CASE2:			MOV R2, CIMA_N2
				CMP R1, R2
				JNZ CASE3
				MOV R5, POSICAO_NINJA2
				JMP SOBE

CASE3:			MOV R9, NINJA2
				MOV R2, BAIXO_N2
				CMP R1, R2
				JNZ CASE4
				MOV R5, POSICAO_NINJA2
				JMP DESCE

CASE4:			MOV R2, CIMA_N3
				CMP R1, R2
				JNZ CASE5
				MOV R5, POSICAO_NINJA3
				JMP SOBE

CASE5:			MOV R9, NINJA3
				MOV R2, BAIXO_N3
				CMP R1, R2
				JNZ CASE6
				MOV R5, POSICAO_NINJA3
				JMP DESCE

CASE6:			MOV R2, CIMA_N4
				CMP R1, R2
				JNZ CASE7
				MOV R5, POSICAO_NINJA4
				JMP SOBE

CASE7:			MOV R9, NINJA4
				MOV R2, BAIXO_N4
				CMP R1, R2
				JNZ d_end
				MOV R5, POSICAO_NINJA4
				JMP DESCE

d_end:
				MOV R2, d_END
				CMP R1, R2 	   		;Verificamos se a tecla premida e a tecla de final de jogo
				JZ update_jogo_fim
				JMP ciclo_inicial

SOBE:			MOV R7, LIM_SUP      ;prepara o setup para subir se estiver nos limites nao
				MOVB R8, [R5]		 
				CMP R8, R7
				JZ limite_superior  ;verifica se esta no limite superior
				MOV R3, -1	        ;se estiver salta caso contrario actualiza a operacao
				MOV R4, 0           ; -1 e para subir
				JMP FINALCASE       ;vai para o final alterar as posicoes

DESCE:			MOV R7, LIM_INF   
				MOVB R8, [R5]
				CMP R8, R7
				JZ limite_inferior  ;se estiver no limite inferior nao altera
				MOV R3, 1          ;1 para descer
				MOV R4, 0
				JMP FINALCASE

limite_superior:
				MOV R3, 0         ;nao altera posicao do ninja assim desenha o sempre na mesma
				MOV R4, 0
				JMP UP

limite_inferior:MOV R3, 0		;nao altera a posicao
				MOV R4,0	
				MOVB [R9], R4    ;altera as flags NINJA para 0 , morto
				CALL atualiza_flag
    			JMP UP
				

FINALCASE:		MOVB R1,[R5]					
				ADD R5, 1
				MOVB R2, [R5]				
				ADD R1, R3		; adiciona 1 para descer e subtrai -1 para subir	
				ADD R2, R4	
				MOVB [R5], R2
				SUB R5, 1
				MOVB [R5], R1
UP:				CALL limpa_ecra     ;limpa o ecra
				CALL verifica_fim   ;verifica se ja morreram todos os ninjas para meter o ecra 
				CALL refresh_screen ;GAME OVER
				JMP ciclo_inicial
				;JMP INT

verifica_fim:	MOV R0, flag
				MOVB R10, [R0]
				CMP R10, 0
				JZ update_jogo_fim
				RET

update_jogo_fim:				
				CALL limpa_ecra
				CALL game_over
				JMP ciclo_inicial
fin:			RET
;************************************************************************************
;*Funcoes para a imagem final de jogo                                            *
;************************************************************************************

					

game_over:				PUSH R0
						PUSH R1
						PUSH R4

						MOV R0, GAME
						MOV R4, 5
						MOV R1, 6
						CALL escreve_final


						MOV R0, OVER
						MOV R4, 16
						MOV R1, 6
						CALL escreve_final

						POP R4
						POP R1
						POP R0
						

						


;R0 endereço da imagem, R4 linha a começar R1 linhas a escrever


escreve_final:			PUSH R0
						PUSH R1
						PUSH R2
						PUSH R4
						PUSH R5
						MOV R2, PIXEL_S			;endereço do byte inicial do ecran
						SHL R4, 2
						ADD R2, R4		
						SHL R1, 2
						ADD R1, R2

escreve_over:			CMP R2, R1
						JGE over
						MOV R4, [R0]		
						MOV [R2], R4		
						ADD R0, 2
						ADD R2, 2
						JMP escreve_over

	over:				POP R5
						POP R4
						POP R2
						POP R1
						POP R0
						RET



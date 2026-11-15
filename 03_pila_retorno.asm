
; Lenguajes de Interfaz - Unidad 3: Modularizacion (la pila en las llamadas)
; Alumno: Giovanni De Jesus Echevarria Yañez
; Grupo: 10-11 
; Docente: Dr. José Luis Medina Jiménez
; Programa: 03_pila_retorno.asm
; Descripcion: Muestra que CALL guarda la direccion de retorno en la cima de
;   la pila ([ESP]). Se imprime [ESP] al entrar a main, procUno y procDos
;   para ver tres direcciones de retorno distintas (llamadas anidadas).
; Salida esperada: tres valores hexadecimales (cambian en cada equipo/ejecucion):
;   1) retorno de main     -> codigo de arranque (fuera de este programa)
;   2) retorno de procUno  -> instruccion "exit" dentro de main
;   3) retorno de procDos  -> instruccion "ret" dentro de procUno
;   Los valores 2 y 3 estan cerca entre si; el 3 es mayor porque procUno
;   esta definido despues de main.


INCLUDE Irvine32.inc

.data

.code
main PROC
	mov eax, [esp]        ; [ESP] = direccion de retorno de main (quien llamo a main)
	call WriteHex         ; imprime EAX en hexadecimal
	call Crlf
	call procUno          ; CALL apila la direccion de "exit"
	exit
main ENDP


; procUno
; Entrada  : ninguna
; Salida   : imprime su direccion de retorno (en main) y llama a procDos
; Modifica : EAX, EDX

procUno PROC
	mov eax, [esp]        ; cima de la pila = retorno hacia main
	call WriteHex
	call Crlf
	call procDos          ; llamada anidada: apila el retorno hacia procUno
	ret                   ; regresa a main (la pila ya esta equilibrada)
procUno ENDP

; procDos
; Entrada  : ninguna
; Salida   : imprime su direccion de retorno (dentro de procUno)
; Modifica : EAX, EDX

procDos PROC
	mov eax, [esp]        ; cima de la pila = retorno hacia procUno
	call WriteHex
	call Crlf
	ret                   ; regresa a procUno; los retornos ocurren en orden inverso
procDos ENDP

END main

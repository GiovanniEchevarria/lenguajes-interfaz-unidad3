
; Lenguajes de Interfaz - Unidad 3: Modularizacion (argumentos en la pila, EBP)
; Alumno: Giovanni De Jesus Echevarria Yañez
; Grupo: 10-11 
; Docente: Dr. José Luis Medina Jiménez
; Programa: 05_marco_pila_ebp.asm
; Descripcion: Pasa dos argumentos por la pila a sumarPila, los localiza con
;   EBP como referencia estable, los multiplica y limpia la pila con RET 8.
;   (A pesar del nombre, la operacion realizada es una MULTIPLICACION.)
; Resultado esperado: EAX = 2 * 1 = 2 y EBX conserva su valor original (10).
;   El programa no imprime nada: se comprueba con el depurador.


INCLUDE Irvine32.inc

.data

.code
main PROC
	mov ebx, 10           ; valor que sumarPila debe conservar (se usa para probar PUSH/POP)
	push 1                ; argumento 1 (queda mas profundo en la pila)
	push 2                ; argumento 2 (queda en la cima antes del CALL)

	call sumarPila        ; apila la direccion de retorno y salta al procedimiento

	nop                   ; punto de parada en el depurador: aqui EAX=2, EBX=10, pila limpia
	exit
main ENDP


; sumarPila
; Entrada  : pila -> [EBP+8] = 2 (ultimo apilado), [EBP+12] = 1
; Salida   : EAX = producto de los dos argumentos
; Conserva : EBX (se guarda con PUSH y se restaura con POP), EBP
; Limpieza : RET 8 retira los 2 argumentos (2 x 4 bytes) -> convencion stdcall

sumarPila PROC
	push ebp              ; guarda el EBP del llamador
	mov ebp, esp          ; EBP = cima actual: referencia fija del marco de pila
	                      ; Marco: [EBP]=EBP viejo, [EBP+4]=retorno, [EBP+8]=arg 2, [EBP+12]=arg 1

	push ebx              ; conserva EBX porque se usa como registro de trabajo
	mov eax, [ebp+8]      ; EAX = 2 (ultimo argumento apilado)
	mov ebx, [ebp+12]     ; EBX = 1 (primer argumento apilado)

	imul eax, ebx         ; EAX = EAX * EBX (imul admite 2 operandos; mul siempre usa EAX)

	pop ebx               ; restaura EBX (vuelve a valer 10)
	pop ebp               ; restaura EBP; ahora la cima es la direccion de retorno
	ret 8                 ; regresa y descarta los 2 argumentos de la pila
sumarPila ENDP

END main

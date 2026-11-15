
; Lenguajes de Interfaz - Unidad 3: Modularizacion (3.1 Procedimientos)
; Alumno: Giovanni De Jesus Echevarria Yañez
; Grupo: 10-11 
; Docente: Dr. José Luis Medina Jiménez
; Programa: 02_procedimientos.asm
; Descripcion: Un mismo procedimiento (mensajeAviso) se llama dos veces para
;   mostrar que una sola definicion se reutiliza y que RET regresa a la
;   instruccion siguiente de cada CALL.
; Salida esperada:
;   inicio de programa
;   Estoy dentro del procedimiento
;   Estoy dentro del procedimiento
;   Fin del programa
INCLUDE Irvine32.inc

.data
	mensajeInicio        BYTE "inicio de programa", 0
	mensajeProcedimiento BYTE "Estoy dentro del procedimiento", 0
	mensajeFin           BYTE "Fin del programa", 0

.code
main PROC
	mov edx, OFFSET mensajeInicio     ; EDX = direccion del mensaje inicial
	call WriteString
	call Crlf

	; Primera llamada: CALL guarda en la pila la direccion de "mov eax, 10"
	call mensajeAviso

	mov eax, 10                       ; se ejecuta SOLO despues de que RET regresa

	; Segunda llamada: EIP salta a las instrucciones del procedimiento
	call mensajeAviso

	mov eax, 20                       ; de nuevo, continua aqui despues del RET

	mov edx, OFFSET mensajeFin
	call WriteString
	call Crlf

	exit                              ; fin del programa (evita caer en el procedimiento)
main ENDP


; mensajeAviso
; Entrada  : ninguna
; Salida   : imprime "Estoy dentro del procedimiento" y salto de linea
; Modifica : EDX

mensajeAviso PROC
	mov edx, OFFSET mensajeProcedimiento
	call WriteString
	call Crlf
	ret                               ; saca de la pila la direccion de retorno y la carga en EIP
mensajeAviso ENDP

END main

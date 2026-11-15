
; Lenguajes de Interfaz - Unidad 3: Modularizacion (3.2 Macros)
; Alumno: Giovanni De Jesus Echevarria Yañez
; Grupo: 10-11 
; Docente: Dr. José Luis Medina Jiménez
; Programa: 01_macros.asm
; Descripcion: Define dos macros y las usa desde main.
;   - MostrarMensaje: imprime una cadena terminada en 0 y un salto de linea.
;   - Multi: multiplica dos enteros e imprime el resultado con signo.
; Salida esperada:
;   BIENVENIDO AL SISTEMA DE GLOWUP MAKEUP SINALOA
;   ADIOS
;   +20

INCLUDE Irvine32.inc

; MostrarMensaje
; Parametro : texto -> etiqueta de una cadena BYTE terminada en 0
; Modifica  : EDX
; Nota      : al ser macro, MASM copia estas 3 lineas en cada uso
;             (no hay CALL/RET), sustituyendo "texto" por el argumento.

MostrarMensaje MACRO texto
	mov edx, OFFSET texto      ; EDX = direccion de la cadena (lo que pide WriteString)
	call WriteString           ; imprime la cadena
	call Crlf                  ; salto de linea
ENDM

; Multi
; Parametros: num1, num2 -> valores inmediatos (o registros) a multiplicar
; Salida    : imprime num1 * num2 con signo (WriteInt); resultado queda en EAX
; Modifica  : EAX, EDX (WriteInt/Crlf pueden alterar registros)

Multi MACRO num1, num2
	mov eax, num1              ; EAX = primer operando
	imul eax, num2             ; EAX = EAX * num2 (imul admite 2 operandos)
	call WriteInt              ; imprime EAX como entero con signo (ej. +20)
	call Crlf                  ; salto de linea
ENDM

.data
	mensajeBienvenida BYTE "BIENVENIDO AL SISTEMA DE GLOWUP MAKEUP SINALOA", 0
	mensajeFin        BYTE "ADIOS", 0

.code
main PROC
	MostrarMensaje mensajeBienvenida   ; expande la macro con la cadena de bienvenida
	MostrarMensaje mensajeFin          ; segunda expansion, ahora con la despedida

	Multi 4, 5                         ; imprime +20

	exit                               ; termina el programa (faltaba en la version original)
main ENDP
END main

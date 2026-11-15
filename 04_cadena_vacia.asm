
; Alumno: Giovanni De Jesus Echevarria Yañez
; Grupo: 10-11 
; Docente: Dr. José Luis Medina Jiménez
; Programa: 04_cadena_vacia.asm
; Descripcion: Pide una cadena al usuario y valida si esta vacia revisando
;   su primer byte (0 = terminador nulo => no se escribio nada).
; Salida esperada:
;   - Solo Enter            -> "La cadena ESTA vacia."
;   - Cualquier texto       -> "La cadena NO esta vacia."


INCLUDE Irvine32.inc

.data
    cadena     BYTE 50 DUP(0)     ; buffer de 50 bytes, inicializado en 0
    msgPedir   BYTE "Ingresa una cadena (o presiona Enter para dejarla vacia): ", 0
    msgVacia   BYTE "La cadena ESTA vacia.", 0
    msgNoVacia BYTE "La cadena NO esta vacia.", 0

.code
main PROC
    ; 1. Pedir y leer la cadena
    mov  edx, OFFSET msgPedir
    call WriteString              ; muestra la indicacion al usuario

    mov  edx, OFFSET cadena       ; EDX = donde se guardara lo escrito
    mov  ecx, SIZEOF cadena - 1   ; ECX = maximo de caracteres; se deja 1 byte para el 0 final
    call ReadString               ; lee hasta Enter; EAX = cantidad de caracteres leidos

    ; 2. Validar si esta vacia comprobando el primer byte
    cmp  BYTE PTR [cadena], 0     ; el primer caracter es el terminador nulo (0)?
    je   EsVacia                  ; si es 0, no se escribio nada

NoEsVacia:
    mov  edx, OFFSET msgNoVacia   ; hay al menos un caracter
    call WriteString
    call Crlf
    jmp  Fin                      ; salta la rama de "vacia" para no ejecutarla tambien

EsVacia:
    mov  edx, OFFSET msgVacia
    call WriteString
    call Crlf

Fin:
    exit
main ENDP
END main

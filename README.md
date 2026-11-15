# Lenguajes de Interfaz – Unidad 3. Modularización

Alumno: Giovanni De Jesus Echevarria Yañez
Grupo: 10-11 
Docente: Dr. José Luis Medina Jiménez

Programas en ensamblador MASM (32 bits) con la librería Irvine32, sobre procedimientos, la pila y macros. Todo el código está comentado.

| Archivo | Qué hace |
|---|---|
| `01_macros.asm` | Define las macros `MostrarMensaje` (imprime una cadena) y `Multi` (multiplica e imprime). |
| `02_procedimientos.asm` | Llama dos veces al procedimiento `mensajeAviso` para mostrar la reutilización y el regreso con `RET`. |
| `03_pila_retorno.asm` | Imprime `[ESP]` en `main`, `procUno` y `procDos` para ver las direcciones de retorno guardadas por `CALL`. |
| `04_cadena_vacia.asm` | Lee una cadena y valida si está vacía revisando su primer byte. |
| `05_marco_pila_ebp.asm` | Pasa dos argumentos por la pila, los lee con `EBP`, multiplica y limpia con `RET 8`. |

## Qué se comprobó

**01 – Macros.** La salida son tres líneas: el mensaje de bienvenida, `ADIOS` y `+20`. Se verificó que cada uso de la macro se expande en el lugar donde se escribe (no hay `CALL`) y que `WriteInt` muestra el signo `+`.

**02 – Procedimientos.** Salida: `inicio de programa`, el mensaje del procedimiento **dos veces** y `Fin del programa`. Con el depurador se observó que, tras cada `RET`, la ejecución continúa en la instrucción siguiente al `CALL` (`mov eax, 10` y luego `mov eax, 20`).

**03 – Pila y retorno.** Se imprimen tres valores hexadecimales distintos (cambian entre equipos y ejecuciones). El primero pertenece al código de arranque; el segundo apunta a `exit` dentro de `main`; el tercero apunta al `ret` dentro de `procUno`. Los dos últimos son cercanos entre sí, lo que confirma que cada llamada apila su propia dirección de retorno y que se recuperan en orden inverso.

**04 – Cadena vacía.** Con solo Enter muestra `La cadena ESTA vacia.`; con cualquier texto muestra `La cadena NO esta vacia.`. Se probó además un texto largo (más de 50 caracteres) para confirmar que no desborda el buffer.

**05 – Marco de pila.** Dentro de `sumarPila` se verificó que `[EBP+8]` vale 2 y `[EBP+12]` vale 1. Al llegar al `nop` de `main`: `EAX = 2`, `EBX = 10` (conservado con `PUSH`/`POP`) y `ESP` igual que antes de apilar los argumentos (los limpió `RET 8`).

## Cambios respecto a las versiones originales
- `01`: se agregó `exit` al final de `main` (sin él el programa seguía ejecutando código fuera de `main` al terminar).
- `03`: `WriteHEx` se escribió como `WriteHex`, igual que en Irvine32.
- `04`: `ReadString` recibe `SIZEOF cadena - 1` para dejar un byte al terminador nulo; los comentarios se escribieron sin acentos para evitar caracteres corruptos al ensamblar.
- `05`: se aclaró en los comentarios que `sumarPila` **multiplica** (el nombre sugiere suma).

section .data
    msg_prime db "El numero es primo", 10, 0
    msg_not_prime db "El numero no es primo", 10, 0

section .bss
    number resb 12

section .text
    global _start
    extern scan_num, print_num, print_str, print_newline

_start:
    call scan_num            ; Leer número desde la entrada y almacenarlo en EAX
    mov ebx, eax             ; Guardamos el número en EBX para su verificación

    cmp ebx, 2               ; Si el número es menor que 2, no es primo
    jl no_primo

    mov ecx, 2               ; Inicializamos el divisor en 2

checa_primo:
    mov edx, 0               ; Limpiar el residuo
    div ecx                  ; EAX / ECX, resultado en EAX, residuo en EDX
    test edx, edx            ; Si el residuo es 0, no es primo
    jz no_primo
    inc ecx                  ; Incrementamos el divisor
    mov eax, ebx             ; Restauramos el número original en EAX
    cmp ecx, eax             ; Si ECX == EAX, es primo
    jl checa_primo

primo:
    mov esi, msg_prime       ; Apunta al mensaje de número primo
    call print_str           ; Imprimir mensaje
    jmp fin

no_primo:
    mov esi, msg_not_prime   ; Apunta al mensaje de número no primo
    call print_str           ; Imprimir mensaje

fin:
    call print_newline       ; Nueva línea
    mov eax, 60              ; syscall exit
    xor edi, edi
    syscall
